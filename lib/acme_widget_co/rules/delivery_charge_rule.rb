# frozen_string_literal: true

module AcmeWidgetCo
  module Rules
    class DeliveryChargeRule
      def initialize(cost_structure)
        @sorted_tiers = cost_structure.sort.to_h
      end

      def apply(amount)
        applicable_tier = @sorted_tiers.find { |limit, _| amount < limit }

        case applicable_tier
        when nil
          0.0
        else
          applicable_tier.last
        end
      end
    end
  end
end
