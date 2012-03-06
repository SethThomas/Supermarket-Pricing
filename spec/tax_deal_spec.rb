require 'spec_helper'
describe TaxDeal do

  before :each do
    @checkout = FactoryGirl.build(:checkout)
    @product = FactoryGirl.create(:product)
    @checkout.scan(@product.sku)
  end

  it "removes deal item from the cart" do
    deal = FactoryGirl.build(:tax_deal)
    deal.update(@checkout)
    @checkout.cart.should_not have_key(@product.sku)
  end

  it "updates the total price" do
    deal = FactoryGirl.build(:tax_deal)
    deal.update(@checkout)
    @checkout.total.should be (@product.price + @product.price*deal.tax_rate).to_i
  end

  it "should not modify the cart when no ideal items are present" do
    deal = FactoryGirl.build(:tax_deal, sku: "2468")
    deal.update(@checkout)
    @checkout.cart.should have_key(@product.sku)
  end

  it "should not update total when no deal items are present" do
    deal = FactoryGirl.build(:tax_deal, sku: "2468")
    deal.update(@checkout)
    @checkout.total.should be @product.price
  end

  it "should handle nil skus" do
    deal = FactoryGirl.build(:tax_deal, sku: nil)
    deal.update(@checkout)
    @checkout.total.should be @product.price
    @checkout.cart.should have_key(@product.sku)
  end

  it "should apply no tax rate if tax rate is not set " do
    deal = FactoryGirl.build(:tax_deal, tax_rate: nil)
    deal.update(@checkout)
    @checkout.total.should be @product.price
    @checkout.cart.should_not have_key("1234")
  end

end
