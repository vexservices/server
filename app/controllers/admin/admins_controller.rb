class Admin::AdminsController < Admin::AdminController
  set_tab :admins

  before_action :set_admin, only: [:edit, :update, :destroy, :login]

  def index
    if current_franchise.present?
      @admins = current_franchise.admins.order('name ASC')
    end

    @admins ||= Admin.order('name ASC')
    @admins   = @admins.includes(:franchise).page(params[:page])

    respond_with @admins
  end

  def new
    @admin = Admin.new
    respond_with @admin
  end

  def edit
    respond_with @admin
  end

  def create
    if current_franchise.present?
      @admin = current_franchise.admins.new(admins_params)
    else
      @admin = Admin.new(admins_params)
    end

    flash[:notice] = t('flash_messages.created', model: Admin.model_name.human) if @admin.save
    respond_with @admin, :location => admin_admins_url
  end

  def update
    if params[:admin][:password].blank?
      params[:admin].delete("password")
      params[:admin].delete("password_confirmation")
    end

    if @admin.update_attributes(admins_params)
      flash[:notice] = t('flash_messages.updated', model: Admin.model_name.human)
      sign_in @admin, :bypass => true
    end

    respond_with @admin, :location => admin_admins_url
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: Admin.model_name.human) if @admin.destroy
    respond_with @admin, :location => admin_admins_url
  end

  def login
    if current_franchise.present?
      flash[:error] =  t('messages.not_authorized')
      redirect_to admin_root_path
    else
      sign_out(current_admin) if current_admin

      sign_in @admin, bypass: true

      redirect_to admin_root_path
    end
  end

  protected

    def set_admin
      if current_franchise.present?
        @admin = current_franchise.admins.find(params[:id])
      else
        @admin = Admin.find(params[:id])
      end
    end

    def admins_params
      params.require(:admin).permit(
        :name, :email, :password, :password_confirmation, :master_admin,
        stores_ids: []
      )
    end
end
