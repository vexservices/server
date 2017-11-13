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
end
