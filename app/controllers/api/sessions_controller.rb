class Api::SessionsController < Api::ApiController
  include Devise::Controllers::Helpers
  acts_as_token_authentication_handler_for User, only: [:destroy]

  before_action :ensure_params_exist, except: [:destroy]

  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])

    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      render json: {
        success: true,
        auth_token: resource.authentication_token,
        email: resource.email,
        store_name: resource.store_name,
        store_id: resource.store_id
      }
    else
      invalid_login_attempt
    end
  end

  def destroy
    current_user.authentication_token = nil

    if current_user.save
      current_user.devices.delete_all

      render json: { success: true, message: "Signed out successfully" }, status: 200
    end
  end

  protected

    def ensure_params_exist
      return unless params[:user].blank?
      render json: { success: false, message: "missing user_login parameter" }, status: 422
    end

    def invalid_login_attempt
      warden.custom_failure!
      render json: { success: false, message: "Error with your login or password" }, status: 401
    end
end
