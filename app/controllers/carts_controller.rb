class CartsController < ApplicationController
  include Cartable
  
  before_action :set_cart_with_cart_products

  def show
  end
end
