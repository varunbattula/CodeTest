require './lib/client.rb'
require './lib/tweet_data.rb'

url = 'https://stream.twitter.com/1.1/statuses/sample.json'

oauth_config = {
    :consumer_key     => 'coByzQgUa78l6yE4JundNjJpH',
    :consumer_secret  => 'UyCgLhJoZhpu5yY78U7FaMgwYpnEtoN67xtYEuPti6F9Sp12lP',
    :access_token     => '4823257306-06RKVr3aHvfI8Y2WOhSUb1dijNiYsQLJD2Xra6V',
    :access_token_secret => 'I96QXddVpzK8JdEPzO3xmU2zYqlU7tKoUsOF8vY5nTDsP'
    }

tc = Twitter::Client.new(url,oauth_config)

tc.connect do |hash|
  if hash.has_key?(:text)
   td= Twitter::TweetData.new(hash) 
   td.display_tweet
  end
end