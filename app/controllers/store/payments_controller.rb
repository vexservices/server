class Store::PaymentsController < Store::StoreController
  before_action :set_store

  def edit
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: t('labels.payment')) if @store.update_attributes(stores_params)
    respond_with @store, location: stores_path
  end

  private
    def set_store
      @store = current_store
    end

    def stores_params
      params.require(:store).permit(
        :payment_option
      )
    end
end
