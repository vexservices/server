class AddSellerAndCommissionToSellers < ActiveRecord::Migration
  def change
    add_reference :sellers, :seller, index: true
    add_column :sellers, :commission, :decimal, precision: 8, scale: 2
  end
end
