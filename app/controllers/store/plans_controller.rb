class Store::PlansController < Store::StoreController
  def show
    @plan = current_store.plan
    @recurring = current_store.recurrings.actives.first

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

  def update
    @plan = Plan.where(id: params[:plan_id]).first

    if @plan.present? && current_store.can_update_plan?
      current_store.plan_id = @plan.id
      current_store.plan_updated_at = DateTime.current

      flash[:notice] = t('flash_messages.updated', model: Plan.model_name.human) if current_store.save
    end

    respond_with @plan, location: plan_path
  end
end
