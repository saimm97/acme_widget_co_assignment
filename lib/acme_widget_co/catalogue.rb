# frozen_string_literal: true

module AcmeWidgetCo
  class Catalogue
    attr_reader :products

    def self.collection(products = [])
      @collection ||= new(products)
    end

    def initialize(products = [])
      @products = products.each_with_object({}) do |product, object|
        object[product.code] = product
      end
    end

    def get(product_code)
      products[product_code]
    end

    def add(product)
      products[product.code] = product
    end

    private_class_method :new
  end
end
