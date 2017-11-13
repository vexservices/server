class RemoveFeaturedFormPublishes < ActiveRecord::Migration
  def change
    remove_column :publishes, :featured, :boolean, default: false
  end
end
