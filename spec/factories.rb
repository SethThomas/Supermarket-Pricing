require 'factory_girl'

FactoryGirl.define do

  factory :checkout
  factory :simple_deal
  factory :bundle_deal

  factory :buy_get_deal do
    sku "1234"
  end

  factory :tax_deal do
    sku "1234"
    tax_rate 10
  end

  factory :product do
    sku "1234"
    name "chips"
    price 400
  end

end