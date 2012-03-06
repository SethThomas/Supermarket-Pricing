require 'spec_helper'
describe BundleDeal do

  before :each do
    @checkout = FactoryGirl.build(:checkout)
    @chips = Factory(:product, sku: "1234", name: "chips", price: 400)
    @salsa = Factory(:product, sku: "2468", name: "salsa", price: 200)
    @checkout.scan(@chips.sku)
    @checkout.scan(@salsa.sku)
  end

  it "removes deal items from the cart" do
    deal = BundleDeal.new([@chips.sku, @salsa.sku], 300)
    deal.update(@checkout)
    @checkout.cart[@chips.sku].should be 0
    @checkout.cart[@salsa.sku].should be 0
  end

  it "updates the total price" do
    deal = BundleDeal.new([@chips.sku, @salsa.sku], 300)
    deal.update(@checkout)
    @checkout.total.should be 300
  end

  it "should not update price if the bundled products are not present in the cart" do
    # create a deal for products not in the cart
    deal = BundleDeal.new(["4567","9876"], 300)
    deal.update(@checkout)
    # total should be chips + salsa only
    @checkout.total.should be (@chips.price+@salsa.price)
    @checkout.cart.should have_key @chips.sku
    @checkout.cart.should have_key @salsa.sku
  end

end
