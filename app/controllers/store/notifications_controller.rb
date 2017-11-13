class Store::NotificationsController < Store::StoreController
  set_tab :notifications

  before_action :set_notifications

  def new
  end

  def create
    notification = Notification.new(notification_params)
    notification.user = current_user
    notification.store = current_store

    if notification.save
      redirect_to new_notification_path, notice: t('messages.message_sended')
    else
      redirect_to new_notification_path, alert: t('messages.message_failed')
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:message, :store_id)
  end

  def set_notifications
    @notifications = current_store.notifications
                                  .includes(:user)
                                  .page(params[:page])
  end
end
