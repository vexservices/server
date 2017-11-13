class Api::PicturesController < Api::ApiController
  acts_as_token_authentication_handler_for User

  before_action :set_picture, except: [ :create ]

  def show
  end

  def create
    @product = Product.find(params[:product_id])

    Rails.logger.debug "Params: #{ params.inspect }"

    @picture = @product.pictures.build

    if params[:file]
      @picture.file = ConvertBase64ImageService.call(params[:file])
    end

    if @picture.save
      render :show, id: @picture.id, product_id: @product.id
    else
      render json: { success: false, errors: @picture.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    if @picture.destroy
      render json: { success: true, status: :ok }
    else
      render json: { success: false, status: :unprocessable_entity }
    end
  end

  private

    def set_picture
      @picture = Picture.find(params[:id])
    end

    def picture_params
      params.require(:picture).permit(:file, :image_data)
    end
end
