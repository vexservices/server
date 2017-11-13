class Store::ClientsController < Store::StoreController
  set_tab :clients

  before_action :set_client, only: [:edit, :update, :destroy]

  def index
    @clients = current_store.clients.page(params[:page])
  end

  def new
    @client = current_store.clients.build
  end

  def create
    @client  = current_store.clients.build(clients_params)

    store_ids = clients_params.delete(:store_ids)

    if @client.save
      flash[:notice] = t('flash_messages.created', model: Client.model_name.human)

      if store_ids
        @client.store_ids = store_ids.split(',')
      end
    end

    respond_with @client, location: clients_path
  end

  def edit
  end

  def update
    if params[:client][:password].blank?
      params[:client].delete("password")
    end

    store_ids = clients_params.delete(:store_ids)

    if @client.update_attributes(clients_params)
      flash[:notice] = t('flash_messages.updated', model: Client.model_name.human)

      if store_ids
        @client.store_ids = store_ids.split(',')
      end
    end

    respond_with @client, location: clients_path
  end

  def destroy
    if @client.destroy
      flash[:notice] = t('flash_messages.deleted', model: Client.model_name.human)
    end

    respond_with @client, location: clients_path
  end

  private

    def set_client
      @client = current_store.clients.find(params[:id])
    end

    def clients_params
      params.require(:client).permit(
        :name, :username, :password, :blocked, :admin, :store_ids
      )
    end
end
