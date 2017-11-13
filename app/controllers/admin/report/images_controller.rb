class Admin::Report::ImagesController < Admin::AdminController
  include AdminPolicies

  set_tab :report

  def index
    @images = Image.invalid
                   .order('created_at ASC')
                   .includes(:store)
                   .page(params[:page])
  end
end
