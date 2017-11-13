class SellerObserver < ActiveRecord::Observer
  def before_create(seller)
    master = seller.seller

    if master.present? && master.franchise_id.present?
      seller.franchise_id = master.franchise_id
    end
  end
end
