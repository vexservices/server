namespace :publishes do
  task :verify => :environment do
    publishes = Publish.to_check.includes(:product)

    publishes.each do |publish|
      publish.product.try(:touch)
    end
  end
end
