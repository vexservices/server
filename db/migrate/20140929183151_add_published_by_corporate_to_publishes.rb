class AddPublishedByCorporateToPublishes < ActiveRecord::Migration
  def change
    add_column :publishes, :published_by_corporate, :boolean, default: false, null: false
  end
end