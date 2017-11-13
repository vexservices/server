class UserSignupForm
  include ActiveModel::Model

  attr_reader :user, :store, :address, :app

  attr_accessor :name, :email, :password, :corporate_name, :phone, :cell_phone,
    :official_email, :time_zone, :street, :city, :state, :zip, :country, :contact,
    :about, :app_name, :short_description, :keywords, :department, :business,
    :seller_name, :seller_number, :subdomain, :domain

  def initialize(attributes = nil, options = {})
    if attributes
      self.name                  = attributes['name']
      self.email                 = attributes['email']
      self.password              = attributes['password']
      self.password_confirmation = attributes['password_confirmation']
      self.corporate_name        = attributes['corporate_name']
      self.cell_phone            = attributes['cell_phone']
      self.phone                 = attributes['phone']
      self.official_email        = attributes['official_email']
      self.time_zone             = attributes['time_zone']
      self.street                = attributes['street']
      self.city                  = attributes['city']
      self.state                 = attributes['state']
      self.zip                   = attributes['zip']
      self.country               = attributes['country']
      self.contact               = attributes['contact']
      self.about                 = attributes['about']
      self.app_name              = attributes['app_name']
      self.short_description     = attributes['short_description']
      self.keywords              = attributes['keywords']
      self.department            = attributes['department']
      self.business              = attributes['business']
      self.seller_name           = attributes['seller_name']
      self.seller_number         = attributes['seller_number']
      self.subdomain             = attributes['subdomain']
      self.domain                = attributes['domain']
    end
  end

  validates  :name, :email, :password, :corporate_name, :app_name,
    :time_zone, :street, :cell_phone, :city, :state, :zip, :country,
    :short_description, :department, :about, :keywords, :business,
    presence: true

  validates :password, confirmation: true, length: { in: 8..128 }
  validates :app_name, length: { in: 3..35 }, format: { with: /\A[a-zA-Z][a-zA-Z0-9 ]+\z/ }
  validates :short_description, length: { in: 20..80 }
  validates :about, length: { minimum: 80 }

  validates :email, format: { with: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/ }

  validates :official_email, format: { with: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/ },
    allow_blank: true

  validate :verify_unique_email
  validate :verify_unique_app_name

  def persisted?
    false
  end

  def self.model_name
    User.model_name
  end

  def submit
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

    def verify_unique_email
      if User.exists? email: email.downcase
        errors.add :email, I18n.t('errors.messages.taken')
      end
    end

    def verify_unique_app_name
      if App.exists? name: app_name
        errors.add :app_name, I18n.t('errors.messages.taken')
      end
    end

    def persist!
      seller      = Seller.where(number: seller_number).first   if seller_number
      franchise   = Franchise.where(subdomain: subdomain).first if subdomain
      franchise ||= Franchise.where(domain: domain).first if domain

      plan =
        if franchise.present?
          franchise.plans.visibles.order('price ASC').first
        else
          Plan.master.visibles.order('price ASC').first
        end

      @store = Store.create!(
        name: corporate_name,
        cell_phone: cell_phone,
        phone: phone,
        official_email: official_email,
        time_zone: time_zone,
        plan: plan,
        contact: contact,
        about: about,
        short_description: short_description,
        keywords: keywords,
        department_id: department,
        business_id: business,
        vender_name: seller_name,
        seller_id: seller ? seller.id : nil,
        franchise_id: franchise ? franchise.id : nil,
        corporate: true
      )

      @app = @store.create_app!(
        name: app_name
      )

      @address = @store.create_address!(
        street: street,
        city: city,
        state: state,
        zip: zip,
        country: country
      )

      @user = @store.users.create!(
        name: name,
        email: email.downcase,
        password: password
      )
    end
end
