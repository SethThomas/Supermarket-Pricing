require "observer"

class SimpleDeal

  attr_accessor :sale_sku,:sale_price

  # sku - the product sku
  # price - the new price for the product
  def initialize(sku=nil,price=nil)
    @sale_sku= sku
    @sale_price= price.to_i unless price.nil?
  end

  def update(checkout)
    # if the deal applies
    if checkout.cart.has_key?(@sale_sku) && !@sale_price.nil?
      # update the price
      checkout.total_price += checkout.cart[@sale_sku] * @sale_price
      # remove the item from the cart
      checkout.cart.delete(@sale_sku)
    end
  end
end