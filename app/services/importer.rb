class Importer
  require 'open-uri'
  attr_reader :job, :store, :spreadsheet, :log, :header

  def initialize(job)
    @job = job
    @store = job.store
    @spreadsheet = open_spreadsheet(job.file)
    @header = spreadsheet.row(1)
    @log = []
  end

  def import
    @log << "Started at: #{ DateTime.now }"

    if job.product?
      import_products
    elsif job.branch_store?
      import_stores
    elsif job.department?
      import_departments
    else
      @log << "Invalid type"
    end

    @log << "Finished at: #{ DateTime.now }"

    job.update_attributes(
      closed: true,
      success: true,
      log: log.join("\n")
    )
  rescue => e
    job.update_attributes(
      success: false,
      closed: true,
      log: "Error: #{ e } \n #{ e.backtrace.join("\n") }"
    )
  end

  private

  def open_spreadsheet(file)
    path_or_url = file.path_or_url

    case File.extname(path_or_url)
    when ".ods"  then
      Roo::OpenOffice.new(path_or_url)
    when ".csv"  then
      Roo::CSV.new(path_or_url)
    when ".xls"  then
      Roo::Excel.new(path_or_url)
    when ".xlsx" then
      Roo::Excelx.new(path_or_url)
    else
      raise "Unknown file type: #{file.path}"
    end
  end

  def read
    (2..spreadsheet.last_row).each do |i|
      yield(i)
    end
  end

  def import_products
    read do |line|
      row = Hash[[header, spreadsheet.row(line)].transpose]
      @log << create_product(row)
    end
  end

  def import_stores
    read do |line|
      row = Hash[[header, spreadsheet.row(line)].transpose]
      @log << create_store(row)
    end
  end

  def import_departments
    read do |line|
      row = Hash[[header, spreadsheet.row(line)].transpose]
      @log << create_department(row)
    end
  end

  def create_department(row)
    department = @store.sections.build(name: row['name'])

    if department.save
      "Successfully created Department. ID: #{ department.id }"
    else
      "Errors: #{ department.errors.full_messages.to_sentence }"
    end
  end

  def create_store(row)
    store_params = {
      name: row['name'],
      cell_phone: row['cell_phone'],
      time_zone: row['time_zone'],
      phone: row['phone'],
      contact: row['contact'],
      official_email: row['official_email'],
      website: row['website'],
      about: row['about'],
      register: row['register'],
      keywords: row['keywords'],
      short_name: row['short_name'],
      search: row['search'],
      paid: row['paid'],
      price: row['price'],
      free: row['free'],
      address_attributes: {
        country: row['country'],
        state: row['state'],
        street: row['street'],
        city: row['city'],
        zip: row['zip']
      },

      users_attributes: [{
        name: row['user_name'],
        email: row['email'],
        password: 'password' # TODO: define default password
      }]
    }

    store_params_update = {
      name: row['name'],
      cell_phone: row['cell_phone'],
      time_zone: row['time_zone'],
      phone: row['phone'],
      contact: row['contact'],
      official_email: row['official_email'],
      website: row['website'],
      about: row['about'],
      register: row['register'],
      keywords: row['keywords'],
      short_name: row['short_name'],
      search: row['search'],
      address_attributes: {
        country: row['country'],
        state: row['state'],
        street: row['street'],
        city: row['city'],
        zip: row['zip']
      }
    }

    if (row['id'])
      branch_store = Store.find(row['id'])
      branch_store.assign_attributes(store_params_update)
    else

      branch_store = @store.stores.build(store_params)

      if row['department']
        if department = @store.sections.search_by_name(row['department']).first
          branch_store.departments << department;
        end
      end

      if row['image']
        create_store_logo(branch_store, row['image'])
      end
    end

    if branch_store.save
      "Successfully created Store. ID: #{ branch_store.id }"
    else
      "Code: #{ row['name'] }. Errors: #{ branch_store.errors.full_messages.to_sentence }"
    end
  end

  def create_product(row)
    product   = @store.products.search_by_code(row['code']).first
    product ||= @store.products.build

    product.attributes = row.to_hash.slice('code', 'name', 'description',
      'contact_info', 'show_all', 'regular_price', 'price')

    if row['category']
      product.category = @store.categories.find_or_create_by(name: row['category'])
    end

    if row['store_number']
      if store = Store.find_by_number(row['store_number'])
        product.stores << store
      end
    end

    if product.save
      create_product_images(product, row['images'])

      "Successfully created product. ID: #{ product.id }"
    else
      "Code: #{ row['code'] }. Errors: #{ product.errors.full_messages.to_sentence }"
    end
  end

  def create_product_images(product, images = nil)
    return unless images

    images.split(';').each do |url|
      uri = URI.parse(url)

      if uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
        product.pictures.create(remote_file_url: uri.to_s)
      end
    end
  end

  def create_store_logo(store, image = nil)
    return unless image

    uri = URI.parse(image)

    if uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
      store.remote_logo_url = uri.to_s
    end
  end
end
