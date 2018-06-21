class Store::ProductsController < Store::StoreController
  set_tab :products

  before_action :set_product, except: [:index, :new, :create]
  before_action :set_categories, only: [ :index, :new, :update, :create, :edit ]

  def index
    @q = Product.ransack(params[:q])

    @products = @q.result.merge(policy_scope(Product))

    @products = @products.includes(:pictures, :store, category: [:category])
                         .order('products.name ASC')
                         .page(params[:page])
  end

  def new
    @product = Product.new
  end

  def create
    @product  = current_store.products.build(products_params)
    flash[:notice] = t('flash_messages.created', model: Product.model_name.human) if @product.save
    respond_with @product
  end

  def edit
  end

  def show
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Product.model_name.human) if @product.update_attributes(products_params)
    respond_with @product
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: Product.model_name.human) if @product.destroy
    respond_with @product, location: products_url
  end

  def publish
    authorize @product, :publish?

    if @product.publish(current_store, current_user)
      flash[:notice] = t('flash_messages.published', model: Product.model_name.human)
    else
      flash[:alert] = t('flash_messages.already_published')
    end

    redirect_to :back
  end

  def unpublish
    if @product.unpublish(current_store)
      flash[:notice] = t('flash_messages.unpublished', model: Product.model_name.human)
    end

    redirect_to :back
  end

  def publish_all
    authorize @product, :publish_all?

    if @product.update_attribute(:show_all, true)
      flash[:notice] = t('flash_messages.published', model: Product.model_name.human)
    end

    redirect_to :back
  end

  def unpublish_all
    authorize @product, :unpublish_all?

    if @product.update_attribute(:show_all, false)
      flash[:notice] = t('flash_messages.unpublished', model: Product.model_name.human)
    end

    redirect_to :back
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
        :code, :show_all, :category_id, :payment_option, :banner, store_ids: [],
        properties_attributes: [:id, :name, :value, :_destroy]
      )
    end
end
