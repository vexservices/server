class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.references :franchise, index: true
      t.string :image
      t.string :locale

      t.timestamps
    end
  end
end
