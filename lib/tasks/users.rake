namespace :users do
  task :auth_token => :environment do
    User.all.each(&:save)
  end
end
