class CreateTerms < ActiveRecord::Migration
  def up
    create_table :terms do |t|
      t.integer :version, default: 0, null: false
      t.timestamps
    end

    Term.create_translation_table! :text => :text, :text => :text
  end

  def down
    drop_table :terms
    Term.drop_translation_table!
  end
end