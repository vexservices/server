class CreateBusinesses < ActiveRecord::Migration
  def up
    create_table :businesses do |t|
      t.timestamps
    end

    Business.create_translation_table! :name => :string
  end

  def down
    drop_table :businesses
    Business.drop_translation_table!
  end
end