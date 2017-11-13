class AddExternalLinkToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :external_link, :string
  end
end
