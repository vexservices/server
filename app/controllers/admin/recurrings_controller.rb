class Admin::RecurringsController < Admin::AdminController
  include AdminPolicies

  before_action :set_store

  def index
    @recurrings = @store.recurrings.page(params[:page])
  end

  def show
    @recurring = @store.recurrings.find(params[:id])
    @logs = @recurring.logs.order(created_at: :desc)
  end

  private

    def set_store
      @store = Store.find(params[:store_id])
    end
end
