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
end
