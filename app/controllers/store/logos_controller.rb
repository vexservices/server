class Store::LogosController < Store::StoreController
  respond_to :html, :js

  def index
    if params[:search]
      if params[:search][:category].present?
        @business = Business.find(params[:search][:category])
        @images = @business.images if @business
      end
    end
  end

  def update
    if @image = Image.find(params[:id])
      current_store.app_logo = @image
      flash[:notice] = t('flash_messages.updated', model: Image.model_name.human) if current_store.save
    end

    respond_with @image, location: image_url
  end
end