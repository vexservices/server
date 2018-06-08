class Store::StoresController < Store::StoreController
  respond_to :html, :json

  set_tab :stores

  before_action :set_store, only: [:show, :edit, :update, :destroy]
  before_action :authorize_action, only: [:show, :edit, :update, :destroy]

  def index
    authorize :store, :index?

    @q = Store.ransack(params[:q])

    @stores = @q.result
                .where(store_id: current_store.id)
                .includes(:address)
                .page(params[:page])
  end

  def new
    authorize :store, :new?

    @store = current_store.stores.build

    @store.users.build
    @store.build_address
  end

  def create
    @store  = current_store.stores.build(stores_params)

    flash[:notice] = t('flash_messages.created', model: Store.model_name.human) if @store.save
    respond_with @store, location: stores_url
  end

  def edit
    @store.build_address unless @store.address.present?
  end

  def show
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Store.model_name.human) if @store.update_attributes(stores_params)
    respond_with @store, location: stores_url
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: Store.model_name.human) if @store.destroy
    respond_with @store, location: stores_url
  end

  def trees
    if params[:client_id] && params[:client_id] != '0'
      @client = Client.find(params[:client_id]) 
    end

    @stores = current_corporate.subtree.order(corporate: :desc, store_id: :asc, short_name: :asc)
  end

  private
    def set_store
      @store = current_store.stores.find(params[:id])
    end

    def authorize_action
      authorize @store
    end

    def stores_params
      params.require(:store).permit(
        :name, :formatted_name, :short_name, :cell_phone, :app_name, :time_zone, :payment_option,
        :plan_id, :phone, :official_email, :website, :contact, :active,
        :about, :logo, :department_id, :sub_department_id, :register, :keywords,
        :search, :paid, :price, :free,
        department_ids: [],
        users_attributes: [:id, :name, :email, :password, :password_confirmation],
        address_attributes: [
          :id, :country, :state, :city, :street, :zip, :latitude, :longitude
        ]
      )
    end
end
