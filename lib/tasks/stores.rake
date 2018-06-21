namespace :stores do
  task fix_plans: :environment do
    corporates = Store.corporates

    corporates.find_each do |corporate|
      corporate.subtree.find_each do |store|
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

  task parse_about: :environment do
    Store.find_each do |store|
      store.contact_button = true
      store.chat_button = true
      store.favorite_button = true
      store.map_button = false 
      store.waze_button = false
      store.show_address = true
      store.show_on_map = false
      store.map_icon = 'marker'
      #store.save
    end
    Store.find_each do |store|
      if (store.about)
        split1 = store.about.split('**')
        if (split1 && split1.length >= 2)
          split2 = split1[1].split(",")
          len = split2.length - 1
          Rails.logger.debug "split1[1]: #{split1[1]}"
          for i in 0..len do
            if (split2[i] == 'hideChatButton')
              store.chat_button = false
            elsif (split2[i] == 'hideContactButton')
              store.contact_button = false
            elsif (split2[i] == 'hideFavoriteButton')
              store.favorite_button = false
            elsif (split2[i] == 'showMapButton')
              store.map_button = true
            elsif (split2[i] == 'hideAddress')
              store.show_address = false
            elsif (split2[i] == 'showOnMap')
              store.show_on_map = true
            elsif (split2[i] == 'fuelIcon')
              store.map_icon = 'fuel'
            elsif (split2[i] == 'foodIcon')
              store.map_icon = 'food'
            elsif (split2[i] == 'exitIcon')
              store.map_icon = 'exit'
            elsif (split2[i] == 'hotelIcon')
              store.map_icon = 'hotel'
            elsif (split2[i] == 'hospitalIcon')
              store.map_icon = 'hospital'
            elsif (split2[i].include? 'storetab')
              split3 = split2[i].split(';')
              if (split3.length >= 2)
                store.store_tab = split3[1]
              end
            elsif (split2[i].include? 'producttab')
              split3 = split2[i].split(';')
              if (split3.length >= 2)
                store.product_tab = split3[1]
              end
            elsif (split2[i].include? 'custombutton')
              split3 = split2[i].split(';')
              if (split3.length >= 4)
                Rails.logger.debug "custombutton: #{split3[1]}, #{split3[2]}, #{split3[3]}" 
                if (split3[2] == 'video')
                  store.video_button_link = split3[3]
                elsif (split3[2] == 'pdf')
                  store.pdf_button_link = split3[3]
                end
              end
            end
          end
          store.save
        end
      end
    end
  end

  task copy_name: :environment do
    Store.find_each do |store|
      store.formatted_name = store.name
      store.save
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
  end
end
