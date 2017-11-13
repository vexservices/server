class AddCategoryIdToImages < ActiveRecord::Migration
  def change
    add_reference :images, :category, index: true
  end
end
