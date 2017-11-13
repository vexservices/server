class Admin::FranchisesController < Admin::AdminController
  include AdminPolicies

  set_tab :franchises

  before_action :set_franchise, only: [:show, :edit, :update, :destroy]

  def index
    @franchises = Franchise.order('created_at DESC').page(params[:page])
    respond_with @franchises
  end

  def new
    @franchise = Franchise.new
    @franchise.admins.build

    respond_with @franchise
  end

  def edit
    respond_with @franchise
  end

  def create
    @franchise = current_admin.franchises.build(franchises_params)

    flash[:notice] = t('flash_messages.created', model: Franchise.model_name.human) if @franchise.save
    respond_with @franchise, :location => admin_franchises_url
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Franchise.model_name.human) if @franchise.update_attributes(franchises_params)
    respond_with @franchise, :location => admin_franchises_url
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: Franchise.model_name.human) if @franchise.destroy
    respond_with @franchise, :location => admin_franchises_url
  end

  protected

    def set_franchise
      @franchise = Franchise.find(params[:id])
    end

    def franchises_params
      params.require(:franchise).permit(
        :name, :subdomain, :domain, :logo, :email, :mx_record, :trial_period,
        admins_attributes: [ :id, :name, :email, :password, :password_confirmation ]
      )
    end
end
