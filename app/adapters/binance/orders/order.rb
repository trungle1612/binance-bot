# frozen_string_literal: true

module Binance
  module Orders
    class Open < Binance::Base
      def process
        get do |response|
          Binance::Order.new response
        end
      end

      def endpoint
        @endpoind ||= '/api/v3/order'
      end
    end
  end
end
