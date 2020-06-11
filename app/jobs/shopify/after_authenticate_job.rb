# frozen_string_literal: true
module Shopify
  class AfterAuthenticateJob < ActiveJob::Base
    def perform(shop_domain:)
      shop = Shop.find_by(shopify_domain: shop_domain)
      order_manager = Services::OrderManager.new(shop)

      shop.with_shopify_session do
        orders = ShopifyAPI::Order.find(:all, params: { limit: 100 })
        order_manager.create_narwhal_orders!(orders)
        while orders.next_page?
          orders = orders.fetch_next_page
          order_manager.create_narwhal_orders!(orders)
        end
      end
    end
  end
end
