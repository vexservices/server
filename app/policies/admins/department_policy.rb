class Admins::DepartmentPolicy < Admins::ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def edit?
    true
  end
end
