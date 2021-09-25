require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  def setup_cart
    get cart_url

    Cart.find(session[:cart_id])
  end

  test "create order" do
    # Arrange
    cart = setup_cart

    cart.cart_products << cart_products(:minecraft, :stardew_valley)

    # Act
    post orders_url

    # Assert
    assert_redirected_to(cart_url)

    assert_equal('Pedido criado com sucesso', flash[:notice])
    assert_nil(session[:cart_id])
  end

  test "invalid order" do
    # Arrange
    cart = setup_cart

    # Act
    post orders_url

    # Assert
    assert_redirected_to(cart_url)

    assert_equal('Erro ao criar o pedido', flash[:notice])
    refute_nil(session[:cart_id])
  end
end
