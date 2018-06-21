class Api::ProductsController < Api::ApiController
  acts_as_token_authentication_handler_for User

  before_action :set_product, except: [:index, :new, :create]
  before_action :set_categories, only: [ :new, :edit ]

  def index
    @publishes = current_store.publishes.active

    @products = policy_scope(Product)

    if params[:search]
      @products = @products.search(params[:search])
    end

    @products = @products.includes(:category, :pictures)
                         .order('name ASC')
                         .page(params[:page])
  end

  def new
  end

  def create
    @product  = current_store.products.build(products_params)

    if @product.save
      render :show, id: @product.id
    else
      render json: { success: false, errors: @product.errors, status: :unprocessable_entity }
    end
  end

  def edit
  end

  def show
  end

  def update
    if @product.update_attributes(products_params)
      render :show, id: @product.id
    else
      render json: { success: false, errors: @product.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    if @product.destroy
      render json: { success: true, status: :ok }
    else
      render json: { success: false, status: :unprocessable_entity }
    end
  end

  def publish
    authorize @product, :publish?

    if @product.publish(current_store, current_user)
      render json: { success: true, status: :ok }
    else
      render json: { success: false, status: :ok }
    end
  end

  def unpublish
    if @product.unpublish(current_store)
      render json: { success: true, status: :ok }
    else
      render json: { success: false, status: :ok }
    end
  end

  def publish_all
    authorize @product, :publish_all?

    if @product.update_attribute(:show_all, true)
      render json: { success: true, status: :ok }
    else
      render json: { success: false, status: :ok }
    end
  end

  def unpublish_all
    if @product.update_attribute(:show_all, false)
      render json: { success: true, status: :ok }
    else
      render json: { success: false, status: :ok }
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def set_categories
      @categories = CategoryPolicy::Scope.new(current_user, Category).resolve.master.includes(:categories)
    end

    def products_params
      params.require(:product).permit(
        :name, :description, :regular_price, :price, :contact_info,
        :code, :show_all, :category_id, :payment_option, :banner
      )
    end
end
