class OrdersController < ApplicationController
  include Cartable

  before_action :set_cart_with_cart_products

  def create
    result = CreateOrder.call(cart: @cart)

    if result[:success]
      clear_cart!
      redirect_to cart_url, notice: 'Pedido criado com sucesso'
    else
      redirect_to cart_url, notice: 'Erro ao criar o pedido'
    end
  end

  private

  def clear_cart!
    @cart.destroy
    session.delete(:cart_id)
  end
end
