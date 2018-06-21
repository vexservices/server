class AddPdfButtonLinkToStores < ActiveRecord::Migration
  def change
    add_column :stores, :pdf_button_link, :string
    add_column :stores, :video_button_link, :string
  end
end
