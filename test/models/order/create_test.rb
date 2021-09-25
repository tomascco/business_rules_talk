require "test_helper"

class Order::CreateTest < ActiveSupport::TestCase
  def calculate_total(cart_products)
    cart_products.reduce(0) do |sum, cart_product|
      sum += cart_product.quantity * cart_product.product.price
    end
  end

  test 'valid order' do
    # Arrange
    cart = carts(:cart)

    # Act
    result = Order::Create.call(cart: cart)

    # Assert
    assert(result.success?)
    assert_kind_of(Order, result[:order])

    # Side Effects
    expected_total_price = calculate_total(cart.cart_products)

    order = result[:order]

    assert_equal(expected_total_price, order.total_price)
    assert_equal(cart.cart_products.size, order.order_products.size)
  end

  test 'invalid cart products' do
    # Arrange
    cart = carts(:invalid_cart)

    # Act
    result = Order::Create.call(cart: cart)

    # Assert
    assert(result.failure?)
  end

  test 'empty cart' do
  # Act
  cart = Cart.new

  # Assert
  result = Order::Create.call(cart: cart)

  # Assert
  assert(result.failure?)
  end
end
