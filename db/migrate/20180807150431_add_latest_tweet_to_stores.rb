class AddLatestTweetToStores < ActiveRecord::Migration
  def change
    add_column :stores, :latest_tweet, :string
  end
end
