class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.text :html
      t.string :locale
      t.references :franchise, index: true

      t.timestamps
    end
  end
end
