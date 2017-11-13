class AddFeatureLevelToPublishes < ActiveRecord::Migration
  def change
    add_column :publishes, :feature_level, :integer, default: 0, null: false
  end
end
