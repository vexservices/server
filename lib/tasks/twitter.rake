namespace :twitter do
  desc "latest_tweet"
  task latest_tweet: :environment do

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    Store.all.each do |store|
      if (store.twitter && !store.twitter.blank?)
        user_timeline = client.user_timeline(store.twitter, {count: 1, include_rts: false, trim_user: true, exclude_replies: true, include_entities: true})
        user_timeline.each do |tweet|
          puts "store.twitter: #{store.twitter}"
          puts "tweet.id: #{tweet.id}"
          puts "store.latest_tweet_id: #{store.latest_tweet_id}"
          if (tweet.id != store.latest_tweet_id.to_i) 
            sleep(2)
            SendNotificationWorker.perform_async(store.id,"#{tweet.text}")
            store.latest_tweet_id = tweet.id 
            store.latest_tweet = tweet.text
            store.save
          end
        
        end
      end
    end
  end
end
