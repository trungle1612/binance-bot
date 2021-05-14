# frozen_string_literal: true

module Binance
  module Orders
    class Index < Binance::Base
      # get all orders
      # params:
      # - symbol - LTCBTC (mandatory)
      # - timestamp - 1499827319559 (mandatory)
      def process
        results = []
        get do |response|
          response do |order|
            results << result.new(
              order["symbol"], order["orderId"], order["orderListId"], order["clientOrderId"],
              order["price"], order["origQty"], order["executedQty"], order["cummulativeQuoteQty"],
              order["status"], order["timeInForce"], order["type"], order["side"], order["stopPrice"],
              order["icebergQty"], order["time"], order["updateTime"], order["isWorking"], order["origQuoteOrderQty"],
            )
          end
        end
      end

      def endpoint
        @endpoind ||= '/api/v3/openOrders'
      end

      def result
        Struct.new(
          :symbol,
          :order_id,
          :order_list_id,
          :client_order_id,
          :price,
          :orig_qty,
          :executed_qty,
          :cummulative_Quote_Qty,
          :status,
          :time_in_force,
          :type,
          :side,
          :stop_price,
          :ice_berg_qty,
          :time,
          :update_time,
          :is_working,
          :orig_quote_order_qty
        )
      end

      def example
        [
          {
            "symbol": "LTCBTC",
            "orderId": 1,
            "orderListId": -1, #Unless OCO, the value will always be -1
            "clientOrderId": "myOrder1",
            "price": "0.1",
            "origQty": "1.0",
            "executedQty": "0.0",
            "cummulativeQuoteQty": "0.0",
            "status": "NEW",
            "timeInForce": "GTC",
            "type": "LIMIT",
            "side": "BUY",
            "stopPrice": "0.0",
            "icebergQty": "0.0",
            "time": 1499827319559,
            "updateTime": 1499827319559,
            "isWorking": true,
            "origQuoteOrderQty": "0.000000"
          }
        ]
      end
    end
  end
end
