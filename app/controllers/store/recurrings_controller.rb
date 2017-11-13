class Store::RecurringsController < Store::StoreController
  def destroy
    if @recurring = current_store.recurrings.actives.first
      if RecurringService.new(@recurring).cancel
        flash[:notice] = t('flash_messages.recurring_cancel')
      end
    end

    respond_with @recurring, location: plan_path
  end
end
