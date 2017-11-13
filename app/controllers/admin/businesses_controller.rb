class Admin::BusinessesController < Admin::AdminController
  include AdminPolicies

  set_tab :businesses

  before_action :set_business, only: [:show, :edit, :update, :destroy]

  def index
    @businesses = Business.includes(:translations).page(params[:page])
  end

  def new
    @business  = Business.new
  end

  def create
    @business  = Business.new(businesses_params)
    flash[:notice] = t('flash_messages.created', model: Business.model_name.human) if @business.save
    respond_with @business, location: admin_business_url(@business)
  end

  def show
  end

  def edit
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Business.model_name.human) if @business.update_attributes(businesses_params)
    respond_with @business, location: admin_business_url(@business)
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: Business.model_name.human)  if @business.destroy
    respond_with @business, location: admin_businesses_path
  end

  private

    def set_business
      @business = Business.find(params[:id])
    end

    def businesses_params
      params.require(:business).permit(:name, :name_en, :name_pt_br, :name_es, :key)
    end
end
