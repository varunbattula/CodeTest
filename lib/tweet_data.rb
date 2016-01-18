module Twitter
  class TweetData

    attr :tweet , :username , :datetime

    def initialize(hash)
      @hash = hash
      @tweet = hash[:text]
      @username = hash[:user][:screen_name]
      @datetime = hash[:user][:created_at]
    end

    def display_tweet
      p "username #{username} :: tweet #{tweet} :: datetime #{datetime}"
    end
  end
end