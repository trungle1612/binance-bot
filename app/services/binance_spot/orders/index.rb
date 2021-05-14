require 'openssl'

module BinanceSpot
  module Orders
    class Index
      attr_reader :timestamp
  
      def initialize
        @timestamp = Time.now.utc.strftime("%s%3N")
      end
  
      def call!
        Binance::Orders::Index.new(params.merge(signature: signature)).process
      end
  
      def server_time
        Binance::ServerTime.new.process
      end
  
      def signature
        secret       = ENV['BINANCE_API_SECRET_KEY']
        digest = OpenSSL::Digest::SHA256.new
  
        payload = params.map {|key, value| "#{key}=#{value}"}.join('&')
        OpenSSL::HMAC.hexdigest(digest, secret, payload)
      end
  
      def params
        {
          recvWindow: 5000,
          timestamp: @timestamp
        }
      end
    end
  end
end
