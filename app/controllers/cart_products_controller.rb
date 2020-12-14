class CartProductsController < ApplicationController
  include Cartable

  before_action :set_cart, only: :create
  before_action :set_cart_product, only: [:update, :destroy]

  def create
    @cart_product = @cart.cart_products.new(cart_product_params)

    if @cart_product.save
      redirect_to root_path, notice: 'Produto adicionado!'
    else
      render root_path
    end
  end

  def update
    if @cart_product.update(cart_product_params)
      redirect_to cart_path, notice: 'Cart was successfully updated.'
    else
      render cart_path
    end
  end

  def destroy
    @cart_product.destroy
    redirect_to cart_path, notice: 'Cart was successfully destroyed.'
  end

  private

    def set_cart_product
      @cart_product = CartProduct.find(params[:id])
    end

    def cart_product_params
      params.require(:cart_product).permit(:cart_id, :quantity, :product_id)
    end
end
