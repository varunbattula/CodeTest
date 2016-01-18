require './lib/client.rb'
require './lib/tweet_data.rb'

url = 'https://stream.twitter.com/1.1/statuses/sample.json'

oauth_config = {
    :consumer_key     => '',
    :consumer_secret  => '',
    :access_token     => '',
    :access_token_secret => ' '
    }

tc = Twitter::Client.new(url,oauth_config)

tc.connect do |hash|
  if hash.has_key?(:text)
   td= Twitter::TweetData.new(hash) 
   td.display_tweet
  end
end