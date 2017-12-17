class BranchStoresController < ApplicationController
  layout 'login'

  before_action :set_corporate
  before_action :check_corporate

  def new
    @store = @corporate.stores.new
    @store.build_address
    @store.users.build
  end

  def create
    @store = @corporate.stores.build(store_params)

    if @store.save
      flash[:notice] = t('flash_messages.created', model: Store.model_name.human)
      redirect_to categories_path
    else
      render :new
    end
  end

  private

    def set_corporate
      @corporate = Store.find(params[:corporate_id])
    end

    def check_corporate
      unless @corporate.present?
        redirect_to root_path
      end
    end

    def store_params
      params.require(:store).permit(
        :name, :short_name, :cell_phone, :app_name, :time_zone, :payment_option,
        :plan_id, :phone, :official_email, :website, :contact, :about, :logo,
        :department_id, :sub_department_id, :register, :search,
        users_attributes: [:id, :name, :email, :password, :password_confirmation],
        address_attributes: [ :id, :country, :state, :city, :street, :zip ]
      )
    end
end
