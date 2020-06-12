module Services
  class OrderManager
    def initialize(shop)
      @shop = shop
    end

    def create_narwhal_orders!(orders)
      orders.each do |order|
        if narwhal?(order)
          unless @shop.narwhal_orders.exists?(name: order.name)
            @shop.narwhal_orders.create(
              name: order.name,
              order_id: order.id,
              customer: "#{order.try(:customer)&.first_name} #{order.try(:customer)&.last_name}"
            )
          end
        end
      end
    end

    private

    def narwhal?(order)
      order.line_items.any? { |item| item.title.match?(/\b(narwhal)\b/i) }
    end
  end
end
