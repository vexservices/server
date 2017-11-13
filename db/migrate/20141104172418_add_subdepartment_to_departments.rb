class AddSubdepartmentToDepartments < ActiveRecord::Migration
  def change
    add_reference :departments, :department, index: true
  end
end
