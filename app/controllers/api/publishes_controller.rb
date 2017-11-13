class Store::PublishesController < Store::StoreController
  def feature
    @publish = current_store.publishes.find(params[:id])

    if @publish.feature
      render json: { success: true, status: :ok }
    else
      render json: { success: false, status: :ok }
    end
  end
end
