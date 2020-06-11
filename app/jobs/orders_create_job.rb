class OrdersCreateJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
    shop = Shop.find_by(shopify_domain: shop_domain)

    if shop.nil?
      logger.error("#{self.class} failed: cannot find shop with domain '#{shop_domain}'")
      return
    end

    order_manager = Services::OrderManager.new(shop)
    shop.with_shopify_session do
      order_manager.create_narwhal_orders!([ShopifyAPI::Order.new(webhook)])
    end
  end
end
