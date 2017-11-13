class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :store, index: true
      t.references :user, index: true
      t.text :message

      t.timestamps
    end
  end
end
