require "observer"

#  The Checkout class servers as a driver for this supermarket pricing coding exercise.
#
#  cart - A hash of product skus to the number of products scanned.  e.g. {"1234"=>3} means that
#        the product with sku "1234" has been scanned 3 times.
#  total_price - An integer representing the total price of the items scanned in
class Checkout
  include Observable

  attr_reader :cart
  attr_accessor :total_price

  def initialize (deal=nil)
    @cart= {}
    @total_price = 0
    add_observer deal unless deal.nil?
  end

  def scan(sku)
    @cart[sku]||= 0
    @cart[sku]+=1
    # let the observers (deals) know there is something new to calculate
    changed
  end

  def total
    # notify all the deals to update the cart and total_price as necessary
    notify_observers(self)
    # get all items remaining in the cart after the deals were applied
    products = Product.find_all_by_sku(@cart.keys)
    # calculate total price
    @total_price += products.inject(0) {|sum,product| sum + (product.price * cart[product.sku])}
  end

  # support adding multiple deals
  def deal=(deal)
    add_observer deal
  end

end