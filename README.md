Supermarket Pricing Exercise
-------------------------
This project contains one possible solution to the Supermarket Coding Exercise.  The goal of this project is to implement
various pricing schemes (buy x get y free, additional tax, sale prices, etc) for a supermarket chain.  New pricing schemes
may be introduced over time, so the solution must be flexible to account for this change.


My Solution
-------------------------

I used rubys built-in support for the observer pattern to implement this solution.

The Checkout class, which is observable, keeps track of all scanned products and the total price for the scanned items.  Each
deal is implemented as an observer of the Checkout class.  At chekcout, each deal is asked to apply their particular
algorithm to the products in the shopping cart, updating the cart contents and total price accordingly.


Assumptions
-------------------------
* All prices are integers, in no particular unit.


Directory Layout
-------------------------
* config - contains database.yml for ActiveRecord configuration
* db - stores database migrations
* feaatures - cucumber tests
* models - the model objects used to implement the spermarket pricing schemes
* spec - rspec tests


How do I see it work?
-------------------------

This solution uses [Bundler](http://gembundler.com/) for dependency management.  Checkout the application and type

    bundle
from the root of the checkout.

Next, create the products database by typing

    rake migrate

This project was developed using Cucumber and Rspec.

To run the [Cucmber](http://cukes.info) tests, type

    cucumber

To run the Rspec unit tests, type

    rspec spec/<deal class name>_spec.rb
