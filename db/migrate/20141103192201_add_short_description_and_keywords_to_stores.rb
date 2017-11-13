class AddShortDescriptionAndKeywordsToStores < ActiveRecord::Migration
  def change
    add_reference :stores, :department, index: true
    add_reference :stores, :sub_department, index: true
    add_column :stores, :short_description, :text
    add_column :stores, :keywords, :text
  end
end
