class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :store, index: true
      t.string :file

      t.timestamps
    end
  end
end
