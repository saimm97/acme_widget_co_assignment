# frozen_string_literal: true

module AcmeWidgetCo
  module Rules
    class OfferRule
      attr_reader :product_code, :trigger_quantity, :discount_rate

      def initialize(product_code, quantity, discount_rate)
        @product_code = product_code
        @trigger_quantity = quantity
        @discount_rate = discount_rate
      end

      def apply(item_list)
        eligible_items = item_list.select { |item| item.code == @product_code }

        return 0.0 if eligible_items.length < @trigger_quantity

        discount_count = eligible_items.length / @trigger_quantity
        item_price = eligible_items.first.price

        discount_count * item_price * @discount_rate
      end
    end
  end
end
