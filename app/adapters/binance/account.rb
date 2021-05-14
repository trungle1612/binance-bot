
module Binance
  class Account
    attr_reader :maker_commission, :taker_commission, :buyer_commission, :seller_commission, :can_trade,
                :can_withdraw, :can_deposit, :update_time, :account_type, :balances

    def initialize account
      @maker_commission  = account['makerCommissionn']
      @taker_commission  = account['takerCommission']
      @buyer_commission  = account['buyerCommission']
      @seller_commission = account['sellerCommission']
      @can_trade         = account['canTrade']
      @can_withdraw = account['canWithdraw']
      @can_deposit  = account['canDeposit'] 
      @update_time  = account['updateTime']
      @account_type = account['accountType']
      @balances     = account['accountType'].map { |balance| Balance.new(balance) }
    end

  end

  class Balance
    attr_reader :asset, :free, :locked

    def new balance
      @asset  = balance['asset']
      @free   = balance['free']
      @locked = balance['locked']
    end
  end
end
