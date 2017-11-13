namespace :pins do
  task :clear => :environment do
    Pin.where('DATE(created_at) <= ?', 45.days.ago.to_date).destroy_all
  end
end