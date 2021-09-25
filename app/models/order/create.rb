require 'result'

class Order
  module Create
    extend self

    def call(cart:)
      return Result.failure if invalid_cart_products?(cart)

      order = Order.new

      order_total = 0
      cart.cart_products.each do |cart_product|
        total = cart_product.quantity * cart_product.product.price

        order_total += total

        order.order_products.new(
          name: cart_product.product.name,
          quantity: cart_product.quantity,
          price: total
        )
      end
      order.total_price = order_total

      return Result.success if order.save

      Result.failure
    end

    private

    def invalid_cart_products?(cart)
      return true if cart.cart_products.blank?

      cart.cart_products.any? { |cart_product| cart_product.quantity < 1 }
    end
  end
end
