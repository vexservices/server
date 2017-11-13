class AddSellersCountToSellers < ActiveRecord::Migration
  def change
    add_column :sellers, :sellers_count, :integer, default: 0, null: false
  end
end
