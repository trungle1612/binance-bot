# frozen_string_literal: true

module Binance
  class Base
    attr_accessor :params

    def initialize(params: nil, security_type: nil)
      @params = params
      @security_type = security_type
    end

    private 

    def endpoint
      raise NotImplementedError
    end

    def get
      @params.merge!(signature: signature) if @security_type.in?(require_signature)

      response = client.get(endpoint, @params) do |req|
        req.headers['X-MBX-APIKEY'] = ENV['BINANCE_API_KEY'] if @security_type.in?(require_api_key)
        req.headers['Content-Type'] = "application/json; charset=utf-8"
      end

      raise ApiCallError unless response.success?
      puts JSON.parse(response.body)
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

    def signature
      secret       = ENV['BINANCE_API_SECRET_KEY']
      digest = OpenSSL::Digest::SHA256.new

      payload = params.map {|key, value| "#{key}=#{value}"}.join('&')
      OpenSSL::HMAC.hexdigest(digest, secret, payload)
    end

    def require_signature
      %w(TRADE USER_DATA MARGIN)
    end

    def require_api_key
      %w(TRADE USER_DATA MARGIN USER_STREAM MARKET_DATA)
    end
  end
end
