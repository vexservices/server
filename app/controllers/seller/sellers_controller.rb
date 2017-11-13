class Seller::SellersController < Seller::SellerController
  set_tab :sellers

  before_action :set_seller, only: [:show, :edit, :update, :destroy]

  def index
    if params[:seller_id]
      @seller = Seller.find(params[:seller_id])
    end

    @seller ||= current_seller

    @sellers = @seller.sellers.includes(:address, :franchise).page(params[:page])
    respond_with @sellers
  end

  def new
    @seller = current_seller.sellers.new

    respond_with @seller
  end

  def edit
    raise Pundit::NotAuthorizedError unless Seller::SellerPolicy.new(current_seller, @seller).edit?

    respond_with @seller
  end

  def show
  end

  def create
    @seller = current_seller.sellers.new(sellers_params)

    flash[:notice] = t('flash_messages.created', model: Seller.model_name.human) if @seller.save
    respond_with @seller, :location => seller_sellers_url
  end

  def update
    raise Pundit::NotAuthorizedError unless Seller::SellerPolicy.new(current_seller, @seller).update?

    if params[:seller][:password].blank?
      params[:seller].delete("password")
      params[:seller].delete("password_confirmation")
    end

    flash[:notice] = t('flash_messages.updated', model: Seller.model_name.human) if @seller.update_attributes(sellers_params)
    respond_with @seller, :location => seller_sellers_url
  end

  def destroy
    raise Pundit::NotAuthorizedError unless Seller::SellerPolicy.new(current_seller, @seller).destroy?

    flash[:notice] = t('flash_messages.deleted', model: Seller.model_name.human) if @seller.destroy
    respond_with @seller, :location => seller_sellers_url
  end

  protected

    def set_seller
      @seller = current_seller.sellers.find(params[:id])
    end

    def sellers_params
      params.require(:seller).permit(
        :name, :email, :phone, :cell_phone, :commission,
        :password_confirmation, :password, :document
      )
    end
end
