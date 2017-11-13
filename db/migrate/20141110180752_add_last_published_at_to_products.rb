class AddLastPublishedAtToProducts < ActiveRecord::Migration
  def change
    add_column :products, :last_published_at, :datetime
    add_column :products, :last_unpublished_at, :datetime
  end
end
