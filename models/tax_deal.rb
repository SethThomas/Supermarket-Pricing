require "observer"

class TaxDeal

  attr_accessor :sku, :tax_rate

  # sku - the product sku
  # tax_rate - the tax rate that applies to this product
  def initialize(sku=nil, tax_rate=100.0)
    @sku= sku
    @tax_rate= tax_rate.to_f/100.0
  end

  # prevent people from setting a tax_rate of nil
  # could also use ActiveModel Validations for more complete error checking
  def tax_rate=(rate)
    @tax_rate= rate.nil? ? 0 : rate.to_f/100.0
  end

  def update(checkout)
    # if the deal applies
    if checkout.cart.has_key? @sku
      product = Product.find_by_sku(@sku)
      # apply the tax rate to the price
      new_price = (product.price + product.price*@tax_rate).to_i
      # update the total price
      checkout.total_price += (new_price * checkout.cart[@sku])
      # remove the product from the cart
      checkout.cart.delete(@sku)
    end
  end

end