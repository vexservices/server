class Store::PublishesController < Store::StoreController
  def feature
    feature_level = params.fetch(:featured) { 1 }

    @publish = current_store.publishes.find(params[:id])

    if @publish.feature(feature_level)
      flash[:notice] = t('flash_messages.featured', model: Product.model_name.human)
    end

    redirect_to :back
  end
end
