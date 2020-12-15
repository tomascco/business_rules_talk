class Orders::Create < Micro::Case
  attributes :cart

  def call!
    fetch_cart_products
      .then(apply(:validate_cart_products))
      .then(apply(:build_order))
      .then(apply(:save_order))
  end

  private

  def fetch_cart_products
    return Failure(:empty_cart) if cart.cart_products.empty?

    Success(result: {cart_products: cart.cart_products})
  end

  def validate_cart_products(cart_products:, **)
    if cart_products.any? { |obj| obj.quantity < 0 }
      return Failure(:invalid_quantity)
    else
      Success(result: {cart_products: cart_products})
    end
  end

  def build_order(cart_products:, **)
    order_products_hashes = cart_products.map do |cart_product|
      {
        name: cart_product.product.name,
        price: cart_product.quantity * cart_product.product.price,
        quantity: cart_product.quantity
      }
    end

    order = Order.new
    order.order_products.new(order_products_hashes)
    order.total_price = order_products_hashes.reduce(0) do |sum, order_product|
      sum += order_product[:price]
    end

    Success(result: {order: order})
  end

  def save_order(order:, **)
    return Success(result: {order: order}) if order.save

    Failure(:save_error, result: {errors: order.errors})
  end
end
