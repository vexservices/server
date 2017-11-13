class Admins::CorporatePolicy < Admins::ApplicationPolicy
  def initialize(admin, record)
    @admin  = admin
    @record = record.corporate
  end

  def master_or_can_see_store?
    admin.master_admin? || admin.stores_ids.include?(record.id)
  end

  def index?
    true
  end

  def show?
    master_or_can_see_store?
  end

  def new?
    master_or_can_see_store
  end

  def create?
    new?
  end

  def edit?
    master_or_can_see_store?
  end

  def update?
    edit?
  end

  def destroy?
    admin?
  end

  class Scope
    attr_reader :admin, :scope

    def initialize(admin, scope)
      @admin  = admin
      @scope = scope
    end

    def resolve
      if admin.master_admin?
        Store.corporates
      else
        Store.corporates.where(id: admin.stores_ids)
      end
    end
  end
end
