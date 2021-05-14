namespace :binance do
  desc "Open orders"
  task open_orders: :environment do |_task|
    BinanceOrders::Open.new.call!
  end

  desc "Move mobile uid from user to device"
  task current_order: :environment do |_task|
    BinanceOrders::Order.new.call!
  end
end
