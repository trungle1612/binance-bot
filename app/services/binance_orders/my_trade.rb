require 'openssl'

module BinanceOrders
  class MyTrade
    attr_reader :timestamp

    def initialize
      @timestamp = Time.now.utc.strftime("%s%3N")
    end

    def call!
      orders = Binance::Orders::MyTrade.new(
        params: params,
        security_type: 'USER_DATA'
      ).process

      puts "symbol------------PRICE---------ORDER"
      orders.each do |order|
        puts "#{order.symbol.to_s.red}---------#{order.price.to_s.red}---------#{order.side}"
      end
    end

    def server_time
      Binance::ServerTime.new.process
    end

    def params
      {
        symbol: 'DOGEUSDT',
        recvWindow: 5000,
        timestamp: @timestamp
      }
    end

    def display
    end
  end
end
