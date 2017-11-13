class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :description
      t.references :recurring, index: true

      t.timestamps
    end
  end
end
