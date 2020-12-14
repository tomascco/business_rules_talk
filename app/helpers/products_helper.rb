module ProductsHelper
  def format_price(number)
    '%d,%02d' % [number / 100, number % 100]
  end
end
