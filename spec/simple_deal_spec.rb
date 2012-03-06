require 'spec_helper'
describe SimpleDeal do

  before :each do
    @checkout = FactoryGirl.build(:checkout)
    @checkout.scan("1234")
  end

  it "removes deal item from the cart" do
    deal = FactoryGirl.build(:simple_deal, sale_sku: "1234", sale_price: 100)
    deal.update(@checkout)
    @checkout.cart.should_not have_key("1234")
  end

  it "updates the total price" do
    deal = FactoryGirl.build(:simple_deal, sale_sku: "1234", sale_price: 100)
    deal.update(@checkout)
    @checkout.total.should be 100
  end

  it "should not modify the cart when no ideal items are present" do
    deal = FactoryGirl.build(:simple_deal, sale_sku: "2468", sale_price: 100)
    deal.update(@checkout)
    @checkout.cart.should have_key("1234")
  end

  it "should not update total when no deal items are present" do
    deal = FactoryGirl.build(:simple_deal, sale_sku: "2468", sale_price: 100)
    deal.update(@checkout)
    @checkout.total.should be 0
  end

  it "should handle nil skus" do
    deal = FactoryGirl.build(:simple_deal, sale_sku: nil, sale_price: 100)
    deal.update(@checkout)
    @checkout.total.should be 0
    @checkout.cart.should have_key("1234")
  end

  it "should handle nil sales price" do
    deal = FactoryGirl.build(:simple_deal, sale_sku: "1234", sale_price: nil)
    deal.update(@checkout)
    @checkout.total.should be 0
    @checkout.cart.should have_key("1234")
  end

end
