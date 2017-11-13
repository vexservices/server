class Api::SchedulesController < Api::ApiController
  acts_as_token_authentication_handler_for User

  before_action :set_schedule, only: [:show, :destroy]

  def index
    @schedules = current_store.schedules.order('initial ASC').page(params[:page])
  end

  def show
  end

  def create
    @schedule = current_store.schedules.build(schedule_params)

    if @schedule.save
      render :show, id: @schedule.id
    else
      render json: { success: false, errors: @schedule.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    if @schedule.destroy
      render json: { success: true, status: :ok }
    else
      render json: { success: false, status: :unprocessable_entity }
    end
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
