class Admin::Report::AppsController < Admin::AdminController
  include AdminPolicies

  set_tab :report

  def index
    @apps = App.with_store.pendent.includes(store: [:image]).page(params[:page])
  end
end
