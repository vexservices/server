class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.references :seller, index: true
      t.string :name
      t.string :number
      t.string :agency

      t.timestamps
    end
  end
end
