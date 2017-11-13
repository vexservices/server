class AddDocumentToSellers < ActiveRecord::Migration
  def change
    add_column :sellers, :document, :string
  end
end
