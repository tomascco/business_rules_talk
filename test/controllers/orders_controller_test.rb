require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    get cart_url
    @cart = Cart.find(session[:cart_id])
  end

  test "create order" do
    @cart.cart_products << cart_products(:one, :two)

    assert_difference('Order.count') do
      post orders_url
    end
    assert_equal('Pedido criado com sucesso', flash[:notice])
    assert_redirected_to cart_url

    # --

    order = Order.last
    expected_total_price = calculate_total(@cart.cart_products)

    assert_equal(@cart.cart_products.size, order.order_products.size)
    assert_equal(expected_total_price, order.total_price)
  end

  test "create empty order" do
    assert_no_difference('Order.count') do
      post orders_url
    end
    assert_equal('Erro ao criar o pedido', flash[:notice])
  end

  test "create invalid quantity order" do
    @cart.cart_products << cart_products(:invalid)
    assert_no_difference('Order.count') do
      post orders_url
    end
    assert_equal('Erro ao criar o pedido', flash[:notice])
  end

  private

  def calculate_total(cart_products)
    cart_products.reduce(0) do |sum, cart_product|
      sum += cart_product.quantity * cart_product.product.price
    end
  end
end
