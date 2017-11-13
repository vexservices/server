class Seller::SellerPolicy < ApplicationPolicy
  attr_reader :seller, :record

  def initialize(seller, record)
    @seller = seller
    @record = record
  end

  def index?
    true
  end

  def show?
    record.seller_id = seller.id
  end

  def new?
    true
  end

  def edit?
    record.seller_id = seller.id
  end

  def create?
    true
  end

  def update?
    record.seller_id = seller.id
  end

  def destroy?
    record.seller_id = seller.id
  end
end
