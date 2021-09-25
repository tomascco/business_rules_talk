require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:minecraft)
  end

  test "visiting the index" do
    visit products_url
  end
end
