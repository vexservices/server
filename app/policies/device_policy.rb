class DevicePolicy < ApplicationPolicy
  attr_reader :user, :store, :record

  def initialize(user, record)
    @user = user
    @store = user.store
    @record = record
  end

  def corporate?
    store.corporate?
  end

  def index?
    corporate?
  end

  def show?
    corporate?
  end

  def update?
    corporate?
  end

  def edit?
    update?
  end

  def destroy?
    corporate?
  end
end
