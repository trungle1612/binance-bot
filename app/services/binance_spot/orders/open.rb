require 'openssl'

module BinanceSpot
  module Orders
    class Open
      attr_reader :timestamp

      def initialize
        @timestamp = Time.now.utc.strftime("%s%3N")
      end

      def call!
        orders = Binance::Orders::Open.new(
          params: params,
          security_type: 'USER_DATA'
        ).process

        orders.each do |order|
          puts "#{order.symbol.to_s.red}---------#{order.price.to_s.red}---------#{order.side}"
        end
      end

      def params
        {
          recvWindow: 5000,
          timestamp: @timestamp
        }
      end

      def display
      end
    end
  end
end
