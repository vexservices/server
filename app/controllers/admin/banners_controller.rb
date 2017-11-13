class Admin::BannersController < Admin::AdminController
  include AdminPolicies

  set_tab :banners

  before_action :set_banner, only: [:edit, :update, :destroy]

  def index
    if current_franchise.present?
      @banners = current_franchise.banners
    end

    @banners ||= Banner.all
    @banners   = @banners.includes(:franchise).page(params[:page])

    respond_with @banners
  end

  def new
    @banner = Banner.new
    respond_with @banner
  end

  def edit
    respond_with @banner
  end

  def create
    if current_franchise.present?
      @banner = current_franchise.banners.new(banners_params)
    else
      @banner = Banner.new(banners_params)
    end

    flash[:notice] = t('flash_messages.created', model: Banner.model_name.human) if @banner.save
    respond_with @banner, :location => admin_banners_url
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Banner.model_name.human) if @banner.update_attributes(banners_params)
    respond_with @banner, :location => admin_banners_url
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: Banner.model_name.human) if @banner.destroy
    respond_with @banner, :location => admin_banners_url
  end

  protected

    def set_banner
      if current_franchise.present?
        @banner = current_franchise.banners.find(params[:id])
      else
        @banner = Banner.find(params[:id])
      end
    end

    def banners_params
      params.require(:banner).permit(
        :image, :locale
      )
    end
end
