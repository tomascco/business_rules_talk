class OrdersController < ApplicationController
  include Cartable

  before_action :set_cart_with_cart_products

  def create
  end

  private

  def clear_cart!
    @cart.destroy
    session.delete(:cart_id)
  end
end
