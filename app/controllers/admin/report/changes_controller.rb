class Admin::Report::ChangesController < Admin::AdminController
  include AdminPolicies

  set_tab :report
  before_action :set_change, except: [:index]

  def index
    @changes = Change.where(checked: false).order('created_at ASC').page(params[:page]).per(10)
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Change.model_name.human) if @change.update_attributes(change_params)
    respond_with @change, :location => admin_report_changes_url
  end

  private

    def set_change
      @change = Change.find(params[:id])
    end

    def change_params
      params.require(:change).permit(:checked)
    end
end
