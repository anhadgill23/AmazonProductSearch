require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validation tests' do
    it 'ensures ASIN presence' do
      product = Product.new.save
      expect(product).to eq(false)
    end
  end

  context 'Insert data' do
    subject {
      Product.new(
        asin: 'XYZ',
        category: 'Lorem ipsum',
        dimensions: 'ABC',
        rank: 'PQR'
      )
    }
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  end
end
