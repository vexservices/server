class Admin::StoresController < Admin::AdminController
  before_action :set_corporate
  before_action :set_store, except: [:index]

  def index
    @q = Store.ransack(params[:q])

    @stores = @q.result
                .where(store_id: @corporate.id)
                .includes(:address)
                .page(params[:page])
  end

  def show
    admin_authorize policy.show?
  end

  def edit
    admin_authorize policy.edit?
  end

  def update
    admin_authorize policy.update?

    if @store.update_attributes(store_params)
      flash[:notice] = t('flash_messages.updated', model: Store.model_name.human)
    end

    respond_with @store, location: admin_corporate_store_url(@corporate, @store)
  end

  def destroy
    admin_authorize policy.destroy?

    if @store.destroy
      flash[:notice] = t('flash_messages.deleted', model: Store.model_name.human)
    end

    respond_with @store, location: admin_corporate_stores_url(@corporate)
  end

  private

    def policy
      Admins::CorporatePolicy.new(current_admin, @corporate)
    end

    def set_corporate
      @corporate = Store.find(params[:corporate_id])
    end

    def set_store
      @store = @corporate.stores.find(params[:id])
    end

    def store_params
      params.require(:store).permit(
        :name, :short_name, :cell_phone, :app_name, :time_zone, :payment_option,
        :plan_id, :phone, :official_email, :website, :contact, :trial_at,
        :blocked, :free_payment, :register, :search,
        address_attributes: [
          :id, :country, :state, :city, :street, :zip, :latitude, :longitude
        ]
      )
    end
end
