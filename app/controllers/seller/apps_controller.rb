class Seller::AppsController < Seller::SellerController
  def index
    if params[:seller_id]
      @seller = Seller.find(params[:seller_id])
      @stores = @seller.stores.corporates
                              .joins(:app)
                              .order('created_at DESC')
                              .page(params[:page])
    end
  end
end
