class CreateOrder < ApplicationService
  attr_reader :cart, :errors

  def initialize(cart:)
    @cart = cart
    @errors = []
  end

  def call
    validate_cart_products
    return failure_hash if errors.any?

    order = Order.new
    order_total = 0
    @cart.cart_products.each do |cart_product|
      total = cart_product.quantity * cart_product.product.price
      order_total += total
      order.order_products.new(
        name: cart_product.product.name,
        quantity: cart_product.quantity,
        price: total
      )
    end
    order.total_price = order_total
    return success_hash(order) if order.save

    @errors = order.errors
    failure_hash
  end 

  private

  def validate_cart_products
    @cart.cart_products.each do |cart_product|
      return @errors << 'invalid quantity' if cart_product.quantity < 1
    end
  end

  def failure_hash
    {success: false, errors: @errors, result: nil}
  end

  def success_hash(order)
    {success: true, errors: @errors, result: order}
  end
end
