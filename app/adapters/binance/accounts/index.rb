# frozen_string_literal: true

module Binance
  module Accounts
    class Index < Binance::Base
      def process
        get do |response|
          response.map do |order|
            Binance::Account.new order
          end
        end
      end

      def endpoint
        @endpoind ||= '/api/v3/account'
      end
    end
  end
end
