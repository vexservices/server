class Admin::ReportsController < Admin::AdminController
  include AdminPolicies

  before_action :set_store

  def download 

    corporate_store = Store.where(id: params[:store_id]).first
    stores = corporate_store.subtree
    temp_file = File.open('/tmp/export.csv','w')
    temp_file.write("id,parent id,number,level,name,short_name,keywords,cell_phone,phone,contact,official_email,website,time_zone,about,department,country,state,city,street,zip,register,paid,price,free,user_name,email,image\n")
    stores.find_each do |store|
      user = store.users.first
      about = ""
      if (store.about)
        about = store.about.squish
        about = about.gsub('"',"'")
        puts "about: #{about}"
      end
      name = ""
      if (store.name)
        name = store.name
        name = name.gsub('"',"'")
      end
      short_name = ""
      if (store.short_name)
        short_name = store.short_name
        short_name = short_name.gsub('"',"'")
      end
      temp_file.write( 
"#{store.id},\
#{store.store_id},\
#{store.number},\
L#{store.ancestry_depth},\
\"#{name}\",\
\"#{short_name}\",\
\"#{store.keywords}\",\
#{store.cell_phone},\
#{store.phone},\
\"#{store.contact}\",\
#{store.official_email},\
#{store.website},\
#{store.time_zone},\
\"#{about}\",\
#{store.department_name},\
#{store.address_country},\
#{store.address_state},\
#{store.address_city},\
\"#{store.address_street}\",\
#{store.address_zip},\
#{store.register},\
#{store.paid},\
#{store.price},\
#{store.free},\
#{user.name},\
#{user.email},\
#{store.logo.url(:original)}")
      temp_file.write("\n")
    end
    temp_file.close





    send_file(
      "/tmp/export.csv",
      filename: "export.csv",
      type: "text/csv"
    )
  end

  private

    def set_store
      @store = Store.find(params[:store_id])
    end
end
