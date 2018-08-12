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
        :name, :formatted_name, :short_name, :cell_phone, :app_name, :time_zone, :logo,
        :phone, :official_email, :website, :contact, :about,
        :keywords, :short_description, :currency, :business_id,
        :register, :search, :paid, :price, :free,
        :contact_button, :map_button, :chat_button, :waze_button, :favorite_button,
        :show_address, :show_on_map, :map_icon,
        :store_tab, :product_tab,
        :pdf_button_link, :video_button_link,
        :twitter, :latest_tweet, :latest_tweet_id,
        :banner,
        department_ids: [],
        address_attributes: [
          :id, :country, :state, :city, :street, :zip,
          :latitude, :longitude
         ],
        app_attributes: [:id, :name],
      )
    end
end
