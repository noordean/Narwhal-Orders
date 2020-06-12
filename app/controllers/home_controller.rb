# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    shop_domain = ShopifyAPI::Shop.current.domain
    shop = Shop.find_by(shopify_domain: shop_domain)
    @narwhal_orders = shop.narwhal_orders.page(params[:page]).per(20)
  end
end
