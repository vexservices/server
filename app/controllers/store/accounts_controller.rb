class Store::AccountsController < Store::StoreController
  before_action :set_store

  def edit
    @store.build_address unless @store.address.present?
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Store.model_name.human) if @store.update_attributes(stores_params)
    respond_with @store, location: edit_account_url
  end

  private
    def set_store
      @store = current_store
    end

    def stores_params
      params.require(:store).permit(
        :name, :short_name, :cell_phone, :app_name, :time_zone, :logo,
        :phone, :official_email, :website, :contact, :about,
        :keywords, :short_description, :currency, :business_id,
        :register, :search, :paid, :price, :free,
        department_ids: [],
        address_attributes: [
          :id, :country, :state, :city, :street, :zip,
          :latitude, :longitude
         ],
        app_attributes: [:id, :name]
      )
    end
end
