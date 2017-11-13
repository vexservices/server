class AddEmailToFranchises < ActiveRecord::Migration
  def change
    add_column :franchises, :email, :string
  end
end
