class Store::MessagesController < Store::StoreController
  respond_to :html, :js

  before_action :set_device, :set_store
  after_action  :read_messages, only: [:unread]

  def index
    @devices = current_store.corporate.devices
    @devices = @devices.with_messages(current_store.subtree_ids).limit(20)

    if @device
      @messages = @device.messages
                         .of_store(@store.id)
                         .order('created_at DESC')
                         .limit(26)

      @messages.unread.update_all(read_at: DateTime.now)
      @messages = @messages.to_a.sort_by(&:created_at)
    end
  end

  def create
    @message = @store.messages.build(messages_params)
    @message.device = @device
    @message.kind = 2
    @message.save

    respond_with @message, location:
      device_store_messages_path(@device, @store, @message, locale: I18n.locale)
  end

  def unread
    @messages = @device.messages
                       .of_store(current_store)
                       .unread
                       .by_device

    render :layout => false
  end

  private

    def set_device
      @device = Device.find(params[:device_id]) if params[:device_id]
    end

    def set_store
      @store = Store.find(params[:store_id]) if params[:store_id]
    end

    def read_messages
      @messages.update_all(read_at: DateTime.now)  if @messages.any?
    end

    def messages_params
      params.require(:message).permit(:message)
    end
end
