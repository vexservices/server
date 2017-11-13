class Store::PicturesController < Store::StoreController
  respond_to :js

  def create
    @product = Product.find(params[:product_id])
    @picture = @product.pictures.create(picture_params)
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
  end

  private

    def picture_params
      params.require(:picture).permit(:file)
    end
end