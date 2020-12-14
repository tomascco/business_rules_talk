require "test_helper"

class CartProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart_product = cart_products(:one)
  end

  test "should create cart_product" do
    assert_difference('CartProduct.count') do
      post cart_products_url, params: { cart_product: { cart_id: @cart_product.cart_id, price: @cart_product.price, quantity: @cart_product.quantity } }
    end

    assert_redirected_to cart_product_url(CartProduct.last)
  end

  test "should destroy cart_product" do
    assert_difference('CartProduct.count', -1) do
      delete cart_product_url(@cart_product)
    end

    assert_redirected_to cart_products_url
  end
end
