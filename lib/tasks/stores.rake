namespace :stores do
  task fix_plans: :environment do
    corporates = Store.corporates

    corporates.find_each do |corporate|
      corporate.stores.find_each do |store|
        store.plan_id ||= corporate.plan_id
        store.save
      end
    end
  end

  task ancestors: :environment do
    corporates = Store.corporates

    corporates.find_each do |corporate|
      corporate.stores.find_each do |store|
        store.parent = corporate
        store.save
      end
    end
  end

  task fix_coordenates: :environment do
    addresses = Address.all

    addresses.find_each do |address|
      address.geocode
      address.save
      sleep(3)
    end
  end

  task count_actives: :environment do
    Store.find_each do |store|
      if corporate = store.store
        corporate.active_stores_count = corporate.stores.actives.count
        corporate.save
      end
    end
  end

  task fix_time_zone: :environment do
    Store.find_each do |store|
      if (store.time_zone == "Eastern Standard Time")
        store.time_zone = "Eastern Time (US & Canada)"
        store.save
      end
    end
  end

  task create_search_name: :environment do
    Store.find_each do |store|
      name = store.name
      name_array = name.split('**')
      len = name_array.length
      if (len > 2)
        name = name_array[len-1]
      end
      name_array = name.split('<br>')
      start_br = name.index('<br>')
      if (start_br == 0)
        name = name_array[1]
      else
        name = name_array[0]
      end 
      if (!name || name.empty?)
        puts "store_name: #{store.name}"
      else
        puts "name: #{name}"
      end 
      store.short_name = name
      store.save
    end
  end
  task :generate_csv, [:corporate_id] => [:environment] do |t, args|
    corporate_store = Store.where(id: args[:corporate_id]).first
    stores = corporate_store.subtree
    temp_file = File.open('/tmp/stores.csv','w')
    temp_file.write("id, parent id, number,level,name,short_name,keywords,cell_phone, phone,contact,official_email,website, time_zone, about,department,country,state,city,address,zip,register,user_name,email,image\n")
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
#{user.name},\
#{user.email},\
#{store.logo.url(:original)}")
      temp_file.write("\n")
    end
    temp_file.close
  end
end
