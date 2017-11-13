class Admin::AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  rescue_from Pundit::NotAuthorizedError, with: :admin_not_authorized

  def current_franchise
    @franchise ||= current_admin.franchise if current_admin.belongs_to_franchise?
  end
  helper_method :current_franchise

  private

    def admin_authorize(policy)
      raise Pundit::NotAuthorizedError unless policy
    end

    def admin_not_authorized
      flash[:error] = t('messages.not_authorized')
      redirect_to(request.referrer || admin_root_path)
    end
end
