class AddTitleToDepartments < ActiveRecord::Migration
  def self.up
    add_column :departments, :title, :string

    Department.create_translation_table!({
      :title => :string
    }, {
      :migrate_data => true
    })
  end

  def self.down
    remove_column :departments, :title

    Department.drop_translation_table! :migrate_data => true
  end
end
