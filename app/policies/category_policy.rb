class CategoryPolicy < ApplicationPolicy
  attr_reader :user, :store, :record

  def initialize(user, record)
    @user  = user
    @store = user.store
    @record = record
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    (user.store_id == record.store_id) || store.corporate?
  end

  def edit?
    update?
  end

  def destroy?
    (user.store_id == record.store_id) || store.corporate?
  end

  class Scope
    attr_reader :user, :store, :scope

    def initialize(user, scope)
      @user  = user
      @store = user.store
      @scope = scope
    end

    def resolve
      Category.where(store_id: store.root.subtree_ids)
    end
  end
end
