require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup { go_shopping }

  test "should get create" do
    assert_difference('Order.count') do
      post orders_url
    end

    assert_equal('Pedido criado com sucesso', flash[:notice])
    assert_redirected_to cart_url
  end

  private

  def go_shopping
    get cart_url
    @cart = Cart.find(session[:cart_id])
    @cart.cart_products << cart_products
  end
end
