require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    # Act
    get cart_url

    # Assert
    assert_response(:success)
  end
end
