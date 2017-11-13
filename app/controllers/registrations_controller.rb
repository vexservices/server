class RegistrationsController < Devise::RegistrationsController
  set_tab :registration

  def new
    @signed_up = UserSignupForm.new
  end

  def create
    @signed_up = UserSignupForm.new(params[:user])

    if @signed_up.submit
      user = @signed_up.user

      set_flash_message :notice, :signed_up if is_flashing_format?
      sign_up(resource_name, user)
      respond_with user, :location => after_sign_up_path_for(user)
    else
      render :new
    end
  end
end
