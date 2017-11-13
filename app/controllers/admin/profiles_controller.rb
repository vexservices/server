class Admin::ProfilesController < Admin::AdminController
  before_action :set_admin

  def edit
  end

  def update
    if params[:admin][:password].blank?
      params[:admin].delete("password")
      params[:admin].delete("password_confirmation")
    end

    if @admin.update_attributes(admin_params)
      flash[:notice] = t('flash_messages.updated', model: Admin.model_name.human)
      sign_in @admin, :bypass => true
    end

    respond_with @admin, location: edit_admin_profile_url
  end

  private
    def set_admin
      @admin = current_admin
    end

    def admin_params
      params.require(:admin).permit(
        :password, :password_confirmation, :name
      )
    end
end
