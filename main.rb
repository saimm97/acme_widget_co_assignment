# frozen_string_literal: true

# ------------------------------------------------------------------------------
# Require application components
# ------------------------------------------------------------------------------
require_relative 'lib/acme_widget_co/product'
require_relative 'lib/acme_widget_co/catalogue'
require_relative 'lib/acme_widget_co/rules/offer_rule'
require_relative 'lib/acme_widget_co/rules/delivery_charge_rule'
require_relative 'lib/acme_widget_co/basket'

# ------------------------------------------------------------------------------
# System Setup
# ------------------------------------------------------------------------------

# Define the product inventory
product_definitions = [
  { code: 'R01', name: 'Red Widget', price: 32.95 },
  { code: 'G01', name: 'Green Widget', price: 24.95 },
  { code: 'B01', name: 'Blue Widget', price: 7.95 }
]

# Populate the product catalogue
product_catalogue = AcmeWidgetCo::Catalogue.collection
product_definitions.each do |p|
  product_catalogue.add(AcmeWidgetCo::Product.new(**p))
end

# Define the pricing rules for this checkout instance
active_rules = [
  # "Buy one Red Widget, get the second half price"
  AcmeWidgetCo::Rules::OfferRule.new('R01', 2, 0.5),

  # Delivery charge rules based on subtotal
  AcmeWidgetCo::Rules::DeliveryChargeRule.new(
    50 => 4.95,
    90 => 2.95
  )
]

# ------------------------------------------------------------------------------
# Helper function to run and display basket totals
# ------------------------------------------------------------------------------

def run_basket_example(catalogue, rules, product_codes, description)
  puts "--- #{description} ---"
  basket = AcmeWidgetCo::Basket.new(catalogue, rules)
  product_codes.each { |code| basket.add(code) }
  basket.print_total
  puts "\n"
end

# ------------------------------------------------------------------------------
# Example Baskets
# ------------------------------------------------------------------------------

# Basket 1: B01, G01
run_basket_example(product_catalogue, active_rules, %w[B01 G01], 'Basket 1') # Expected: $37.85

# Basket 2: R01, R01
run_basket_example(product_catalogue, active_rules, %w[R01 R01], 'Basket 2') # Expected: $54.37

# Basket 3: R01, G01
run_basket_example(product_catalogue, active_rules, %w[R01 G01], 'Basket 3') # Expected: $60.85

# Basket 4: B01, B01, R01, R01, R01
run_basket_example(product_catalogue, active_rules, %w[B01 B01 R01 R01 R01], 'Basket 4') # Expected: $98.27