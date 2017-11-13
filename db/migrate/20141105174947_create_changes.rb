class CreateChanges < ActiveRecord::Migration
  def change
    create_table :changes do |t|
      t.references :changeable, polymorphic: true
      t.text :log
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
