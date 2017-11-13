class CreateDepartmentsDevices < ActiveRecord::Migration
  def change
    create_table :departments_devices do |t|
      t.references :device, index: true
      t.references :department, index: true
    end
  end
end
