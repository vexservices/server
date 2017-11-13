class StorePolicy < ApplicationPolicy
  attr_reader :user, :store, :record

  def initialize(user, record)
    @user = user
    @store = user.store
    @record = record
  end

  def father?
    store.corporate?
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    new?
  end

  def new?
    true
  end

  def update?
    true
  end

  def edit?
    update?
  end

  def destroy?
    true
  end
end
