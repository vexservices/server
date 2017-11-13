class Admin::PlansController < Admin::AdminController
  include AdminPolicies

  set_tab :plans

  before_action :set_plan, only: [:edit, :update, :destroy]

  def index
    if current_franchise.present?
      @plans = current_franchise.plans.order('name ASC')
    end

    @plans ||= Plan.order('name ASC')
    @plans   = @plans.includes(:franchise).page(params[:page])

    respond_with @plans
  end

  def new
    @plan = Plan.new
    respond_with @plan
  end

  def edit
    respond_with @plan
  end

  def create
    if current_franchise.present?
      @plan = current_franchise.plans.new(plans_params)
    else
      @plan = Plan.new(plans_params)
    end

    flash[:notice] = t('flash_messages.created', model: Plan.model_name.human) if @plan.save
    respond_with @plan, :location => admin_plans_url
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Plan.model_name.human) if @plan.update_attributes(plans_params)
    respond_with @plan, :location => admin_plans_url
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: Plan.model_name.human) if @plan.destroy
    respond_with @plan, :location => admin_plans_url
  end

  protected

    def set_plan
      if current_franchise.present?
        @plan = current_franchise.plans.find(params[:id])
      else
        @plan = Plan.find(params[:id])
      end
    end

    def plans_params
      params.require(:plan).permit(
        :name, :monthly_posts, :stores_limit, :popular, :email_support,
        :chat_support, :price, :individual_price, :visible, :price_real
      )
    end
end
