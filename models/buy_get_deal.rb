require "observer"

class BuyGetDeal

  attr_accessor :sku,:buy,:get

  # buy - number of products to buy for this deal
  # get - number of products you get with this deal
  # sku - the product sku
  def initialize(buy=1,get=1,sku)
    @buy,@get,@sku= buy,get,sku
  end

  def update(checkout)
    if @sku && checkout.cart.has_key?(@sku)
      # update the number of products we will really be paying for
      num_deals = checkout.cart[@sku] / (@buy + @get)
      checkout.cart[@sku] -= num_deals * @get
    end
  end

  # dynamically support any arbitrary buyXgetY deals
  def self.method_missing(method, *args)
    buy,get=1
    if /buy_(?<buy>\d+)_get_(?<get>\d+)/ =~ method
      buy = buy.to_i
      get = get.to_i
    end
    BuyGetDeal.new(buy,get,args.first)
  end

end
