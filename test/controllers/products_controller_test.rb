require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    # Act
    get products_url

    # Assert
    assert_response(:success)
  end
end
