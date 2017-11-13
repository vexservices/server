class AddPublishAllUntilToProducts < ActiveRecord::Migration
  def change
    add_column :products, :published_all_until, :datetime
  end
end
