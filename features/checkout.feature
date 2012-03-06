Feature: Checkout
  In order to checkout at the supermarket
  As a clerk
  I want to be able to calculate total cost of the shopping cart
  And automatically apply any discounts

  Scenario: Calculate the total of a shopping cart without incentives
    Given the following products:
      | name  | price | sku |
      | chips | 200   | 123 |
      | salsa | 100   | 456 |
    And I scan item 123
    And I scan item 456
    Then the total price should be 300

  Scenario: Calculate a simple discount
    Given the following products:
      | name  | price | sku |
      | chips | 200   | 123 |
    And I scan item 123
    And chips are on sale for 100
    Then the total price should be 100

  Scenario: Apply additional taxes at checkout
    Given the following products:
      | name | price | sku |
      | wine | 100   | 123 |
    And I scan item 123
    And wine is taxed at 10%
    Then the total price should be 110

  Scenario:  Buy one get one
    Given the following products:
      | name  | price | sku |
      | chips | 200   | 123 |
    And there is a buy 1 get 1 sale on chips
    And I scan item 123
    And I scan item 123
    And I scan item 123
    Then the total price should be 400

  Scenario:  Bundle deal
    Given the following products:
      | name  | price | sku |
      | chips | 200   | 123 |
      | salsa | 300   | 456 |
    And there is a bundle deal on chips and salsa for 400
    And I scan item 123
    And I scan item 456
    Then the total price should be 400