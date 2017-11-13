class Store::PricesController < Store::StoreController
  before_action :set_product
  before_action :set_price, only: [:edit, :update]

  def new
    @price = current_store.prices.new
  end

  def edit
  end

  def create
    @price  = current_store.prices.build(price_params)
    flash[:notice] = t('flash_messages.updated', model: Product.model_name.human) if @price.save
    respond_with @price, location: products_url
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Product.model_name.human) if @price.update_attributes(price_params)
    respond_with @product, location: products_url
  end

  private

    def set_price
      @price = current_store.prices.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def price_params
      params.require(:price).permit(:product_id, :regular_price, :price)
    end
end