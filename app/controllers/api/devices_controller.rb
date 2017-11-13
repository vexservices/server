class Api::DevicesController < Api::ApiController
  acts_as_token_authentication_handler_for User

  before_action :set_device, except: [:create]

  def show
  end

  def create
    @device = current_user.devices.find_or_create_by!(
      push_token: params[:device][:push_token],
      kind: params[:device][:kind]
    )

    if @device.save
      render :show, id: @device.id
    else
      render json: { success: false, errors: @device.errors, status: :unprocessable_entity }
    end
  end

  def update
    if @device.update_attributes(devices_params)
      render :show, id: @device.id
    else
      render json: { success: false, errors: @device.errors, status: :unprocessable_entity }
    end
  end

  private

    def set_device
      @device = current_user.devices.search_by_id_or_token(params[:id]).first
    end

    def devices_params
      params.require(:device).permit(:push_token, :kind, :token)
    end
end
