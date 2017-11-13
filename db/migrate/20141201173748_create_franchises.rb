class CreateFranchises < ActiveRecord::Migration
  def change
    create_table :franchises do |t|
      t.string :name
      t.string :subdomain
      t.string :domain
      t.string :logo

      t.timestamps
    end
  end
end
