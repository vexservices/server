class Admin::PaypalsController < Admin::AdminController
  include AdminPolicies

  set_tab :paypals

  before_action :set_paypal, only: [:edit, :update, :destroy]

  def index
    if current_franchise.present?
      @paypals = current_franchise.paypals
    end

    @paypals ||= Paypal.all
    @paypals   = @paypals.includes(:franchise).page(params[:page])

    respond_with @paypals
  end

  def new
    @paypal = Paypal.new
    respond_with @paypal
  end

  def edit
    respond_with @paypal
  end

  def create
    if current_franchise.present?
      @paypal = current_franchise.paypals.new(paypals_params)
    else
      @paypal = Paypal.new(paypals_params)
    end

    flash[:notice] = t('flash_messages.created', model: Paypal.model_name.human) if @paypal.save
    respond_with @paypal, :location => admin_paypals_url
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Paypal.model_name.human) if @paypal.update_attributes(paypals_params)
    respond_with @paypal, :location => admin_paypals_url
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: Paypal.model_name.human) if @paypal.destroy
    respond_with @paypal, :location => admin_paypals_url
  end

  protected

    def set_paypal
      if current_franchise.present?
        @paypal = current_franchise.paypals.find(params[:id])
      else
        @paypal = Paypal.find(params[:id])
      end
    end

    def paypals_params
      params.require(:paypal).permit(
        :login, :password, :partner, :sandbox, :country, :user
      )
    end
end
