require "observer"

class BundleDeal

  # products - array of skus
  # price - the combined price for the bundle
  def initialize(products, price)
    @product_skus = products
    @price = price.to_i
  end

  def update(checkout)
    # if all of the products related to this deal are in the cart
    if @product_skus.all? { |sku| checkout.cart.has_key? sku }

      # find the maximum number of times we can apply this deal
      max_deals = @product_skus.inject do |memo, sku|
        checkout.cart[sku] > checkout.cart[memo] ? checkout.cart[memo] : checkout.cart[sku]
      end

      # remove the items from the cart pertaining to this deal
      @product_skus.each { |sku| checkout.cart[sku]-=max_deals }

      #update the total price
      checkout.total_price+= max_deals * @price
    end
  end

end