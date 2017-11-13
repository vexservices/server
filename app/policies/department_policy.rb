class DepartmentPolicy < ApplicationPolicy
  attr_reader :user, :store, :record

  def initialize(user, record)
    @user  = user
    @store = user.store
    @record = record
  end

  def can_manage?
    store.has_children?
  end

  def index?
    true
  end

  def show?
    (store.subtree_ids.include?(record.store_id) && can_manage?) || store.corporate?
  end

  def create?
    new?
  end

  def new?
    can_manage? || store.corporate?
  end

  def update?
    show?
  end

  def edit?
    update?
  end

  def destroy?
    show?
  end

  class Scope
    attr_reader :user, :store, :scope

    def initialize(user, scope)
      @user  = user
      @store = user.store
      @scope = scope
    end

    def resolve
      Department.where(store_id: store.root.subtree_ids)
    end
  end
end
