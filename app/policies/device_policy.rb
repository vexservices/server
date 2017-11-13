class DevicePolicy < ApplicationPolicy
  attr_reader :user, :store, :record

  def initialize(user, record)
    @user = user
    @store = user.store
    @record = record
  end

  def index?
    store.corporate?
  end
end
