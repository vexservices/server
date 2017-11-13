class Store::DepartmentsController < Store::StoreController
  set_tab :departments
  before_action :set_department, except: [:index, :new, :create]
  before_action :authorize_action, only: [:edit, :update, :destroy]

  def index
    authorize :department, :index?

    @departments = policy_scope(Department)
    @departments = @departments.order('name ASC').page(params[:page])

    respond_with @departments
  end

  def new
    authorize :department, :new?

    @department = current_store.sections.new
    respond_with @department
  end

  def edit
    respond_with @department
  end

  def create
    authorize :department, :create?

    @department = current_store.sections.build(department_params)

    flash[:notice] = t('flash_messages.created', model: Department.model_name.human) if @department.save
    respond_with @department, :location => departments_url
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Department.model_name.human) if @department.update_attributes(department_params)
    respond_with @department, :location => departments_url
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: Department.model_name.human) if @department.destroy
    respond_with @department, :location => departments_url
  end

  private

    def set_department
      if current_store.corporate?
        @departments = policy_scope(Department)
        @department  = @departments.find(params[:id])
      else
        @department = current_store.sections.find(params[:id])
      end
    end

    def authorize_action
      authorize @department
    end

    def department_params
      params.require(:department).permit(:name)
    end
end
