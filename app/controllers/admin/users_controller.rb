class Admin::UsersController < Admin::AdminController
  before_action :set_user

  def edit
    admin_authorize policy.edit?
  end

  def update
    admin_authorize policy.update?

    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    flash[:notice] = t('flash_messages.updated', model: User.model_name.human) if @user.update_attributes(user_params)
    respond_with @user, location: path
  end

  def destroy
    admin_authorize policy.destroy?

    flash[:notice] = t('flash_messages.deleted', model: User.model_name.human) if @user.destroy
    respond_with @store, location: path
  end

  def login
    admin_authorize policy.show?

    sign_out(current_user) if current_user

    sign_in @user, bypass: true

    redirect_to categories_path
  end

  private

    def policy
      Admins::UserPolicy.new(current_admin, @user)
    end

    def path
      if @user.store_corporate?
        admin_corporate_path(@user.store_id)
      else
        admin_corporate_store_path(@user.store_store_id, @user.store_id)
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :name, :email, :password, :password_confirmation, :blocked
      )
    end
end
