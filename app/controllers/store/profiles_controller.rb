class Store::ProfilesController < Store::StoreController
  before_action :set_user

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    if @user.update_attributes(user_params)
      flash[:notice] = t('flash_messages.updated', model: User.model_name.human) 
      sign_in @user, :bypass => true
    end

    respond_with @user, location: edit_profile_url
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(
        :password, :password_confirmation, :name
      )
    end
end