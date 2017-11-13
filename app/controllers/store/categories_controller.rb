class Store::CategoriesController < Store::StoreController
  set_tab :categories

  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = policy_scope(Category)
    @categories = @categories.master.includes(:categories)
  end

  def new
    @category  = current_store.categories.build
  end

  def create
    @category  = current_store.categories.build(categories_params)
    flash[:notice] = t('flash_messages.created', model: Category.model_name.human) if @category.save
    respond_with @category, location: categories_path
  end

  def edit
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Category.model_name.human) if @category.update_attributes(categories_params)
    respond_with @category, location: categories_path
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: Category.model_name.human)  if @category.destroy
    respond_with @category, location: categories_path
  end

  private

    def set_category
      if current_store.corporate?
        @categories = policy_scope(Category)
        @category   = @categories.find(params[:id])
      else
        @category   = current_store.categories.find(params[:id])
      end
    end

    def categories_params
      params.require(:category).permit(:name, :category_id)
    end
end
