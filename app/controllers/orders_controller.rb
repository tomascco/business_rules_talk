class OrdersController < ApplicationController
  include Cartable

  before_action :set_cart_with_cart_products

  def create
    Orders::Create.call(cart: @cart) do |on|
      on.success do
        clear_cart!
        redirect_to cart_path, notice: 'Pedido criado com sucesso'
      end

      on.failure { redirect_to cart_path, notice: 'Erro ao criar o pedido' }
    end
  end

  private

  def clear_cart!
    @cart.destroy
    session.delete(:cart_id)
  end
end
