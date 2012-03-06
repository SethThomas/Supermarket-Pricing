Given /^the following products:$/ do |table|
  @checkout = Checkout.new
  table.hashes.each do |attributes|
    Product.create!(attributes)
  end
end

Given /^I scan item (\d+)/ do |sku|
  @checkout.scan(sku)
end

Then /^the total price should be (\d+)$/ do |total|
  @checkout.total.should be total.to_i
end

Given /^(\w+) are on sale for (\d+)$/ do |product_name, sale_price|
  product = Product.find_by_name(product_name)
  deal = SimpleDeal.new(product.sku, sale_price)
  @checkout.deal= deal
end

Given /^(\w+) is taxed at (\d+)%$/ do |product_name, tax_rate|
  product = Product.find_by_name(product_name)
  deal = TaxDeal.new(product.sku,tax_rate)
  @checkout.deal= deal
end

Given /^there is a buy (\d+) get (\d+) sale on (\w+)$/ do |buy, get, product_name|
  product = Product.find_by_name(product_name)
  deal = BuyGetDeal.send "buy_#{buy}_get_#{get}",product.sku
  @checkout.deal= deal
end

Given /^I scan (\d+) [can|bag] of (\w+)/ do |quantity,product_name|
  product = Product.find_by_name(product_name)
  quantity.to_i.times do
    @checkout.scan(product.sku)
  end
end

Given /^there is a bundle deal on (\w+) and (\w+) for (\d+)$/ do |product1,product2,price|
  product_skus = Product.find_all_by_name([product1,product2]).collect {|p|p.sku}
  deal = BundleDeal.new(product_skus,price)
  @checkout.deal=deal
end

