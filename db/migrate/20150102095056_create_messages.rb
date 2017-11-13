class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :store, index: true
      t.references :device, index: true
      t.text :message
      t.datetime :read_at
      t.integer :kind, default: 1, null: false

      t.timestamps
    end
  end
end
