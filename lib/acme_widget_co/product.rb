# frozen_string_literal: true

module AcmeWidgetCo
  class Product
    attr_reader :code, :name, :price

    def initialize(code:, name:, price:)
      @code = code
      @name = name
      @price = price
    end
  end
end
