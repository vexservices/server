class Store::DevicesController < Store::StoreController
  def index
    authorize :device, :index?

    @devices = current_corporate.devices.page(params[:page])
  end
end
