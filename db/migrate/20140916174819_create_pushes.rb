class CreatePushes < ActiveRecord::Migration
  def change
    create_table :pushes do |t|
      t.references :store, index: true

      t.timestamps
    end
  end
end
