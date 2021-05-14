require 'openssl'

module BinanceSpot
  module Orders
    class MyTrade
      attr_reader :timestamp, :symbol

      def initialize symbol
        @symbol    = symbol
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

      def params
        {
          symbol: @symbol,
          recvWindow: 5000,
          timestamp: @timestamp
        }
      end

      def display
      end
    end
  end
end
