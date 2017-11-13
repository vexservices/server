class Api::MessagesController < Api::ApiController
  acts_as_token_authentication_handler_for User

  before_action :set_device, :set_store
  after_action  :read_messages, only: [:unread]

  def index
    if @device
      @messages = @device.messages
                         .of_store(store.id)
                         .order('created_at DESC')
                         .limit(26)

      @messages.unread.update_all(read_at: DateTime.now)
      @messages = @messages.to_a.sort_by(&:created_at)
    else
      @devices = current_corporate.devices
                                  .with_messages(store.id)
                                  .limit(20)
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  def create
    @message = Message.new(messages_params)
    @message.device = @device
    @message.store = store
    @message.kind = 2

    if @message.save
      render :show, id: @message.id
    else
      render json: { success: false, errors: @message.errors, status: :unprocessable_entity }
    end
  end

  def unread
    @messages = @device.messages
                       .of_store(store)
                       .unread
                       .by_device
  end

  def stores
    @stores = current_store.subtree
                           .actives
                           .with_messages
                           .page(params[:page])
  end

  private
    def store
      @store || current_store
    end

    def set_device
      @device = Device.find(params[:device_id]) if params[:device_id]
    end

    def set_store
      @store = current_corporate.subtree.find(params[:store_id]) if params[:store_id]
    end

    def read_messages
      @messages.update_all(read_at: DateTime.now) if @messages.any?
    end

    def messages_params
      params.require(:message).permit(:message)
    end
end
