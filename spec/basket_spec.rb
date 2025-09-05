# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcmeWidgetCo::Basket do
  subject(:basket) { described_class.new(catalogue, rules) }

  let(:product_definitions) do
    [
      { code: 'R01', name: 'Red Widget', price: 32.95 },
      { code: 'G01', name: 'Green Widget', price: 24.95 },
      { code: 'B01', name: 'Blue Widget', price: 7.95 }
    ]
  end

  let(:catalogue) { AcmeWidgetCo::Catalogue.collection }

  let(:rules) do
    [
      AcmeWidgetCo::Rules::OfferRule.new('R01', 2, 0.5),
      AcmeWidgetCo::Rules::DeliveryChargeRule.new(50 => 4.95, 90 => 2.95)
    ]
  end

  # Populate the catalogue with products before running the tests
  before do
    product_definitions.each do |p|
      catalogue.add(AcmeWidgetCo::Product.new(**p))
    end
  end

  describe '#total' do
    context 'with a basket containing B01, G01' do
      it 'returns the correct total of 37.85' do
        basket.add('B01')
        basket.add('G01')
        expect(basket.total).to eq(37.85)
      end
    end

    context 'with a basket containing R01, R01' do
      it 'returns the correct total of 54.37' do
        basket.add('R01')
        basket.add('R01')
        expect(basket.total).to eq(54.37)
      end
    end

    context 'with a basket containing R01, G01' do
      it 'returns the correct total of 60.85' do
        basket.add('R01')
        basket.add('G01')
        expect(basket.total).to eq(60.85)
      end
    end

    context 'with a basket containing B01, B01, R01, R01, R01' do
      it 'returns the correct total of 98.27' do
        basket.add('B01')
        basket.add('B01')
        basket.add('R01')
        basket.add('R01')
        basket.add('R01')
        expect(basket.total).to eq(98.27)
      end
    end
  end
end
