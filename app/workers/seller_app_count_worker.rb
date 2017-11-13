class SellerAppCountWorker
  include Sidekiq::Worker

  def perform(seller_id)
    @seller = Seller.find(seller_id)
    @total  = 0

    calculate
  end

  def get_master
    master = @seller

    until master.master?
      master = master.seller
    end

    master
  end

  def calculate
    calculate_children(get_master)
  end

  def calculate_children(seller)
    seller.sellers.find_each do |s|
      if s.sellers.present?
        calculate_children(s)
      else
        s.apps_count = s.stores_count
        s.save

        @total += s.apps_count
      end
    end

    @total += seller.stores_count

    seller.apps_count = @total
    seller.save
  end
end
