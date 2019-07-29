require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validation tests' do
    it 'ensures ASIN presence' do
      product = Product.new.save
      expect(product).to eq(false)
    end
  end

  context 'scope tests' do
    before(:each) do
      
    end
  end
end
