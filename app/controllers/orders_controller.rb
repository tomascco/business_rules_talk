class OrdersController < ApplicationController
  include Cartable

  before_action :set_cart_with_cart_products

  def create
    if invalid_cart_products?
      redirect_to(cart_url, notice: 'Erro ao criar o pedido') and return
    end

    order = Order.new

    order_total = 0
    @cart.cart_products.each do |cart_product|
      total = cart_product.quantity * cart_product.product.price

      order_total += total

      order.order_products.new(
        name: cart_product.product.name,
        quantity: cart_product.quantity,
        price: total
      )
    end
    order.total_price = order_total

    if order.save
      clear_cart!

      redirect_to(cart_url, notice: 'Pedido criado com sucesso')

      return
    end

    redirect_to(cart_url, notice: 'Erro ao criar o pedido')
  end

  private

  def invalid_cart_products?
    return true if @cart.cart_products.blank?

    @cart.cart_products.any? { |cart_product| cart_product.quantity < 1 }
  end

  def clear_cart!
    @cart.destroy
    session.delete(:cart_id)
  end
end
