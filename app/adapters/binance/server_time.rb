# frozen_string_literal: true

module Binance
  class ServerTime < Binance::Base

    def process
      get_without_header do |response|
        response["serverTime"]
      end
    end

    def endpoint
      @endpoind ||= '/api/v3/time'
    end
  end
end
