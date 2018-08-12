class AddLatestTweetIdToStore < ActiveRecord::Migration
  def change
    add_column :stores, :latest_tweet_id, :string
  end
end
