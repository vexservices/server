class Store::ImagesController < Store::StoreController
  before_action :set_image, except: [:new, :create]

  def show
  end

  def new
    @image = current_store.build_image
    authorize @image
  end

  def edit
    authorize @image
  end

  def create
    @image  = current_store.build_image(image_params)

    authorize @image

    flash[:notice] = t('flash_messages.updated', model: Image.model_name.human) if @image.save
    respond_with @image, location: categories_url
  end

  def update
    authorize @image

    flash[:notice] = t('flash_messages.updated', model: Image.model_name.human) if @image.update_attributes(image_params)
    respond_with @image, location: image_url
  end

  private

    def set_image
      @image = current_store.image
    end

    def image_params
      params.require(:image).permit(:file)
    end
end
