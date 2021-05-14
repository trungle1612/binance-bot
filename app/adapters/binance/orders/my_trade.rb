# frozen_string_literal: true

module Binance
  module Orders
    class MyTrade < Binance::Base
      def process
        get do |response|
          response.map do |order|
            Binance::Order.new order
          end
        end
      end

      def endpoint
        @endpoind ||= '/api/v3/myTrades'
      end
    end
  end
end
