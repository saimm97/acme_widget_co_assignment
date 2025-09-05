# frozen_string_literal: true

module AcmeWidgetCo
  class Basket
    attr_reader :catalogue, :rules, :items

    def initialize(catalogue, rules = [])
      @catalogue = catalogue
      @rules = rules
      @items = []
    end

    def add(product_code)
      product = catalogue.get(product_code)
      @items.push(product) if product
    end

    def total
      calculated_summary = summary
      final_total = calculated_summary[:subtotal] - calculated_summary[:discount] + calculated_summary[:delivery]

      (final_total * 100).to_i / 100.0
    end

    def print_total
      puts "#{items.map(&:name).join(', ')}: $#{total}"
    end

    private

    def summary
      subtotal = items.sum(&:price)
      discount = apply_discounts
      delivery = apply_delivery_charge(subtotal - discount)

      { subtotal: subtotal, discount: discount, delivery: delivery }
    end

    def apply_discounts
      rules
        .select { |rule| rule.is_a?(AcmeWidgetCo::Rules::OfferRule) }
        .sum { |rule| rule.apply(items) }
    end

    def apply_delivery_charge(current_total)
      delivery_rule = rules.find { |rule| rule.is_a?(AcmeWidgetCo::Rules::DeliveryChargeRule) }
      delivery_rule ? delivery_rule.apply(current_total) : 0.0
    end
  end
end
