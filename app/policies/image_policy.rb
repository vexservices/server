class ImagePolicy < ApplicationPolicy
  attr_reader :user, :store, :record

  def initialize(user, record)
    @user   = user
    @store  = user.store
    @record = record
  end

  def corporate?
    store.corporate?
  end

  def show?
    corporate?
  end

  def new?
    corporate?
  end

  def edit?
    corporate?
  end

  def create?
    corporate?
  end

  def update?
    edit?
  end
end
