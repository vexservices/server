class Store::DevicesController < Store::StoreController
  before_action :set_device, only: [:edit, :update, :destroy]
  def index
    authorize :device, :index?
    @devices = current_corporate.devices.page(params[:page])
  end

  def destroy
    if @device.destroy
      flash[:notice] = t('flash_messages.deleted', model: Device.model_name.human)
    end

    respond_with @device, location: devices_path
  end

  private

    def set_device
      @device = current_store.devices.find(params[:id])
    end

end
