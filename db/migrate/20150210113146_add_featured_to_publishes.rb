class AddFeaturedToPublishes < ActiveRecord::Migration
  def change
    add_column :publishes, :featured, :boolean, default: false, null: false
  end
end
