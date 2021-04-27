require 'openssl'

module BinanceOrders
  class Index
    attr_reader :timestamp

    def initialize
      #@timestamp = Binance::ServerTime.new.process
      @timestamp = Time.current.to_i*1000
    end

    def call!
      Binance::Orders::Index.new(
        #symbol: 'WINUSDT',
        timestamp: @timestamp,
        #recvWindow: 60_000,
        signature: signature
      ).process
    end

    def server_time
      Binance::ServerTime.new.process
    end

    def signature
      query_string = "timestamp=#{@timestamp}"
      secret       = ENV['BINANCE_API_SECRET_KEY']

      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret, query_string)
    end
  end
end
