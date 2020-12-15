class OrdersController < ApplicationController
  include Cartable

  before_action :set_cart_with_cart_products

  def create
  end
end
