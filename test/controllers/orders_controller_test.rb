require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "create order" do
    # Arrange
    cart = setup_cart

    cart.cart_products << cart_products(:minecraft, :stardew_valley)

    # Act
    assert_difference(-> { Order.count }) do
      post orders_url
    end

    # Assert
    assert_redirected_to(cart_url)
    assert_equal('Pedido criado com sucesso', flash[:notice])

    order = Order.last

    expected_total_price = calculate_total(cart.cart_products)
    assert_equal(expected_total_price, order.total_price)

    assert_equal(cart.cart_products.size, order.order_products.size)
  end

  test "create empty order" do
    # Arrange
    cart = setup_cart

    # Act
    assert_no_difference(-> { Order.count }) do
      post orders_url
    end

    # Assert
    assert_equal('Erro ao criar o pedido', flash[:notice])
  end

  test "create invalid quantity order" do
    # Arrange
    cart = setup_cart

    cart.cart_products << cart_products(:invalid)

    # Act
    assert_no_difference(-> { Order.count }) do
      post orders_url
    end

    # Assert
    assert_equal('Erro ao criar o pedido', flash[:notice])
  end

  private

  def setup_cart
    get cart_url

    Cart.find(session[:cart_id])
  end

  def calculate_total(cart_products)
    cart_products.reduce(0) do |sum, cart_product|
      sum += cart_product.quantity * cart_product.product.price
    end
  end
end
