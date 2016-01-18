require 'em-http'
require 'em-http/middleware/oauth'
require 'multi_json'


module Twitter
  class Client

    attr_accessor :url, :consumer_key , :consumer_secret , :access_token , :access_token_secret

    def initialize(url,config={})
      @url = url
      @consumer_key  = config[:consumer_key]
      @consumer_secret  = config[:consumer_secret]
      @access_token  = config[:access_token]
      @access_token_secret  = config[:access_token_secret]
    end

    def oauth_config
      {
        :consumer_key     => consumer_key,
        :consumer_secret  => consumer_secret ,
        :access_token     => access_token,
        :access_token_secret => access_token_secret 
      }
    end

    def connection
      @connection ||= EventMachine::HttpRequest.new(url)
      @connection.use EventMachine::Middleware::OAuth, oauth_config 
      @connection
    end

    # sign the request with OAuth credentials and start streaming the data from twitter
    def connect(&block) 
      EM.run do
        http = connection.get
        buffer = ""
        http.stream do |chunk|
          buffer << chunk
          while line = buffer.slice!(/.+\r\n/)
            hash= MultiJson.decode(line, :symbolize_keys => true)
            block.call(hash)
          end
        end
        http.errback do
          EM.stop
        end
      end
    end
  end
end











