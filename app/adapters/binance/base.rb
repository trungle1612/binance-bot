# frozen_string_literal: true

module Binance
  class Base

    def initialize(params = nil)
      @params = params
    end

    private

      def endpoint
        raise NotImplementedError
      end

      def data(response, name = nil)
        return unless success?(response)
        name ? response['data'][name] : response['data']
      end

      def success?(response)
        response['status_code'] == 1000
      end

      def get
        response = client.get(endpoint, @params) do |req|
          req.headers['X-MBX-APIKEY'] = ENV['BINANCE_API_KEY']
        end

        byebug
        raise ApiCallError unless response.success?
        yield JSON.parse(response.body)
      end

      def get_without_header
        response = client.get(endpoint, @params)

        raise ApiCallError unless response.success?
        yield JSON.parse(response.body)
      end

      def delete
        response = client.delete(endpoint, @params)

        raise ApiCallError unless response.success?
        yield JSON.parse(response.body)
      end

      def post
        response = client.post(endpoint, @params)

        raise ApiCallError unless response.success?
        yield JSON.parse(response.body)
      end

      def put
        response = client.put(endpoint, @params)

        raise ApiCallError unless response.success?
        yield JSON.parse(response.body)
      end

      def client
        @client ||= Faraday.new(url: ENV['API_URL'])
      end
  end
end
