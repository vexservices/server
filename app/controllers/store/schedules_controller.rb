class Store::SchedulesController < Store::StoreController
  respond_to :html, :js

  set_tab :schedules

  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  def index
    @schedules = current_store.schedules.order('initial ASC').page(params[:page])
  end

  def new
    @schedule = current_store.schedules.build(final: 7.days.from_now)
    @schedule.product_ids = params[:product_ids]
  end

  def create
    @schedule  = current_store.schedules.build(schedule_params)

    flash[:notice] = t('flash_messages.created', model: Schedule.model_name.human) if @schedule.save
    respond_with @schedule, location: schedule_path(@schedule)
  end

  def edit
    @products = ProductPolicy::Scope.new(current_user, Product).resolve
  end

  def show
  end

  def update
    if @schedule.update_attributes(schedule_params)
      flash[:notice] = t('flash_messages.updated', model: Schedule.model_name.human)

      # OPTIMIZE: Fix cache to schedule only change products
      @schedule.touch
    end

    respond_with @schedule, location: schedules_path
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: Schedule.model_name.human) if @schedule.destroy
    respond_with @schedule, location: schedules_url
  end

  private

    def set_schedule
      @schedule = current_store.schedules.find(params[:id])
    end

    def schedule_params
      params.require(:schedule).permit(
        :initial, :final, :run_at, product_ids: []
      )
    end
end
