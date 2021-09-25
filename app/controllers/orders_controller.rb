class OrdersController < ApplicationController
  include Cartable

  before_action :set_cart_with_cart_products

  def create
    result = Order::Create.call(cart: @cart)

    if result.success?
      session.delete(:cart_id)

      redirect_to(cart_url, notice: 'Pedido criado com sucesso')
    else
      redirect_to(cart_url, notice: 'Erro ao criar o pedido')
    end
  end
end
