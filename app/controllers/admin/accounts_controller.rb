class Admin::AccountsController < Admin::AdminController
  include AdminPolicies

  set_tab :franchises

  before_action :set_franchise, only: [:edit, :update]
  before_action :validate_franchise, only: [:edit, :update]

  def edit
    respond_with @franchise
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Franchise.model_name.human) if @franchise.update_attributes(franchises_params)
    respond_with @franchise, :location => edit_admin_account_path
  end

  protected

    def set_franchise
      @franchise = current_franchise
    end

    def validate_franchise
      redirect_to admin_admins_path unless @franchise.present?
    end

    def franchises_params
      params.require(:franchise).permit(
        :name, :subdomain, :domain, :logo, :email, :mx_record, :trial_period
      )
    end
end
