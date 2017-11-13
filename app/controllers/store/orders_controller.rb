class Store::OrdersController < Store::StoreController
  before_action :set_plans, except: [:skip]

  def new
    @order = Order.new
  end

  def create
    @order       = current_store.orders.build(orders_params)
    @order.value = current_store.current_plan_price

    if @order.save
      if @order.make_recurring
        if @order.plan.present?
          current_store.update_attribute(:plan_id, @order.plan)
          current_store.update_attribute(:plan_updated_at, DateTime.current)
        end

        flash[:notice] = t('flash_messages.success.recurring')
        redirect_to categories_path
      else
        flash[:alert] = t('flash_messages.error.recurring')
        redirect_to new_order_path
      end
    else
      render :action => 'new'
    end
  end

  def skip
    current_store.update_attribute(:manual_payment, true)
    redirect_to categories_path
  end

  private

    def set_plans
      if current_franchise.present?
        @plans = current_franchise.plans
                                  .visibles_or_current(current_store.plan_id)
                                  .order('price ASC')
      else
        @plans = Plan.master
                     .visibles_or_current(current_store.plan_id)
                     .order('price ASC')
      end
    end

    def orders_params
      params.require(:order).permit(
        :card_number, :card_verification, :card_expires_on, :first_name,
        :last_name, :card_brand, :address, :zip, :state, :city, :plan
      )
    end
end
