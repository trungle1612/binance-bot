module Binance
  class Order
    attr_reader :symbol, :order_id, :order_list_id, :client_order_id, :price, :orig_qty, :executed_qty,
          :cummulative_Quote_Qty, :status, :time_in_force, :type, :side, :stop_price, :ice_berg_qty,
          :time, :update_time, :is_working, :orig_quote_order_qty

      def initialize(order)
         @symbol                = order["symbol"]
         @order_id              = order["orderId"]
         @order_list_id         = order["orderListId"]
         @client_order_id       = order["clientOrderId"]
         @price                 = order["price"]
         @orig_qty              = order["origQty"]
         @executed_qty          = order["executedQty"]
         @cummulative_Quote_Qty = order["cummulativeQuoteQty"]
         @status                = order["status"]
         @time_in_force         = order["timeInForce"]
         @type                  = order["type"]
         @side                  = order["side"]
         @stop_price            = order["stopPrice"]
         @ice_berg_qty          = order["icebergQty"]
         @time                  = order["time"]
         @update_time           = order["updateTime"]
         @is_working            = order["isWorking"]
         @orig_quote_order_qty  = order["origQuoteOrderQty"]
      end
  end
end
