require "application_system_test_case"

class CartProductsTest < ApplicationSystemTestCase
  setup do
    @cart_product = cart_products(:one)
  end

  test "creating a Cart product" do
    visit cart_products_url
    click_on "New Cart Product"

    fill_in "Cart", with: @cart_product.cart_id
    fill_in "Price", with: @cart_product.price
    fill_in "Quantity", with: @cart_product.quantity
    click_on "Create Cart product"

    assert_text "Cart product was successfully created"
    click_on "Back"
  end

  test "destroying a Cart product" do
    visit cart_products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cart product was successfully destroyed"
  end
end
