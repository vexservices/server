class Api::CategoriesController < Api::ApiController
  acts_as_token_authentication_handler_for User

  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit]

  def index
    @categories = policy_scope(Category)
    @categories = @categories.master.includes(:categories)
  end

  def new
  end

  def create
    @category  = current_store.categories.build(categories_params)

    if @category.save
      render :show, id: @category.id
    else
      render json: { success: false, errors: @category.errors, status: :unprocessable_entity }
    end
  end

  def show
  end

  def edit
  end

  def update
    if @category.update_attributes(categories_params)
      render :show, id: @category.id
    else
      render json: { success: false, errors: @category.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    if @category.destroy
      render json: { success: true, status: :ok }
    else
      render json: { success: false, status: :unprocessable_entity }
    end
  end

  private
    def set_categories
      @categories = policy_scope(Category)
    end

    def set_category
      @category = current_store.categories.find(params[:id])
    end

    def categories_params
      params.require(:category).permit(:name, :category_id)
    end
end
