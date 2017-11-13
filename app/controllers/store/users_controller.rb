class Store::UsersController < Store::StoreController
  set_tab :users

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = current_store.users
    @users = @users.order('name ASC').page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user  = current_store.users.build(users_params)
    flash[:notice] = t('flash_messages.created', model: User.model_name.human) if @user.save
    respond_with @user, location: users_url
  end

  def edit
  end

  def show
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    flash[:notice] = t('flash_messages.updated', model: User.model_name.human) if @user.update_attributes(users_params)
    respond_with @user, location: users_url
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: User.model_name.human) if @user.destroy
    respond_with @user, location: users_url
  end

  private
    def set_user
      @user = current_store.users.find(params[:id])
    end

    def users_params
      params.require(:user).permit(
        :name, :email, :password, :password_confirmation
      )
    end
end
