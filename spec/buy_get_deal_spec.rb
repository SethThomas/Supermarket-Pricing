require 'spec_helper'
describe BuyGetDeal do

  before :each do
    @checkout = FactoryGirl.build(:checkout)
    @product = Factory(:product)
    @checkout.scan(@product.sku)
    @checkout.scan(@product.sku)
    @checkout.scan(@product.sku)
  end

  it "updates the number of items in the cart" do
    deal = BuyGetDeal.buy_1_get_1(@product.sku)
    deal.update(@checkout)
    # buy one get one with 3 items in the cart means you pay for 2
    @checkout.cart[@product.sku].should be 2
  end

  it "updates the number of items in the cart" do
    deal = BuyGetDeal.buy_1_get_2(@product.sku)
    deal.update(@checkout)
    # buy two get one with 3 items in the cart means you pay for 1
    @checkout.cart[@product.sku].should be 1
  end

  it "updates the total price" do
    deal = BuyGetDeal.buy_1_get_1(@product.sku)
    deal.update(@checkout)
    @checkout.total.should be (@product.price * 2)
  end

  it "should not modify the cart when no ideal is present" do
    deal = BuyGetDeal.buy_5_get_1(@product.sku)
    deal.update(@checkout)
    # no products should have been removed from the cart
    @checkout.cart[@product.sku].should be 3
    @checkout.total.should be @product.price*3
  end

end
