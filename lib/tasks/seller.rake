namespace :sellers do
  task :calculate => :environment do
    sellers = Seller.master

    sellers.find_each do |seller|
      SellerAppCountWorker.perform_at(5.seconds.from_now, seller.id)
    end
  end
end
