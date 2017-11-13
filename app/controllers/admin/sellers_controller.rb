class Admin::SellersController < Admin::AdminController
  include AdminPolicies

  set_tab :sellers

  before_action :set_seller, only: [:show, :edit, :update, :destroy, :login]

  def index
    if current_franchise.present?
      @sellers = current_franchise.sellers
    else
      @sellers = Seller.all
    end

    if params[:seller_id].present?
      @seller  = @sellers.find(params[:seller_id])
      @sellers = @seller.sellers
    else
      @sellers = @sellers.master
    end

    @sellers = @sellers.includes(:address, :franchise).page(params[:page])

    respond_with @sellers
  end

  def new
    @seller = Seller.new
    @seller.build_address

    respond_with @seller
  end

  def edit
    respond_with @seller
  end

  def show
  end

  def create
    if current_franchise.present?
      @seller = current_franchise.sellers.new(sellers_params)
    else
      @seller = Seller.new(sellers_params)
    end

    flash[:notice] = t('flash_messages.created', model: Seller.model_name.human) if @seller.save
    respond_with @seller, :location => admin_sellers_url
  end

  def update
    if params[:seller][:password].blank?
      params[:seller].delete("password")
      params[:seller].delete("password_confirmation")
    end

    flash[:notice] = t('flash_messages.updated', model: Seller.model_name.human) if @seller.update_attributes(sellers_params)
    respond_with @seller, :location => admin_sellers_url
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: Seller.model_name.human) if @seller.destroy
    respond_with @seller, :location => admin_sellers_url
  end

  def login
    sign_out(current_seller) if current_seller
    sign_in @seller, bypass: true

    redirect_to seller_root_path
  end

  protected

    def set_seller
      if current_franchise.present?
        @seller = current_franchise.sellers.find(params[:id])
      else
        @seller = Seller.find(params[:id])
      end
    end

    def sellers_params
      params.require(:seller).permit(
        :name, :email, :phone, :cell_phone, :commission, :seller_id,
        :password_confirmation, :password, :document,
        address_attributes: [ :id, :country, :state, :city, :street, :zip ]
      )
    end
end
