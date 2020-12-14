module Cartable
  private

  def set_cart
    return @cart = Cart.find(session[:cart_id]) if session[:cart_id]

    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def set_cart_with_cart_products
    if session[:cart_id]
      return @cart = Cart.includes(cart_products: :product).find(session[:cart_id])
    end

    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end
