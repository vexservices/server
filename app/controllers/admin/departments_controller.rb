class Admin::DepartmentsController < Admin::AdminController
  set_tab :departments
  before_action :set_department, except: [:index, :new, :create]

  def index
    @departments = Department.super.order('name ASC').includes(:departments).page(params[:page]).per(10)
    respond_with @departments
  end

  def new
    @department = Department.new

    admin_authorize policy.new?

    respond_with @department
  end

  def edit
    admin_authorize policy.edit?
    respond_with @department
  end

  def create
    @department = Department.new(department_params)

    admin_authorize policy.create?

    flash[:notice] = t('flash_messages.created', model: Department.model_name.human) if @department.save
    respond_with @department, :location => admin_departments_url
  end

  def update
    admin_authorize policy.update?

    flash[:notice] = t('flash_messages.updated', model: Department.model_name.human) if @department.update_attributes(department_params)
    respond_with @department, :location => admin_departments_url
  end

  def destroy
    admin_authorize policy.destroy?

    flash[:notice] = t('flash_messages.deleted', model: Department.model_name.human) if @department.destroy
    respond_with @department, :location => admin_departments_url
  end

  private

    def policy
      Admins::DepartmentPolicy.new(current_admin, @department)
    end

    def set_department
      @department = Department.find(params[:id])
    end

    def department_params
      params.require(:department).permit(
        :name, :title, :title_en, :title_pt_br, :title_es,
        :department_id
      )
    end
end
