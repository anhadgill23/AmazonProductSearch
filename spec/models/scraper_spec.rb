require 'rails_helper'

RSpec.describe Scraper do
  describe '.get_product_info', :vcr do
    context 'for B002QYW8LW' do
      subject { Scraper.get_product_info('B002QYW8LW') }

      it 'returns the product name' do
        expect(subject[:name]).to eql 'Baby Banana Infant Training Toothbrush and Teether'
      end

      it 'returns the product category' do
        expect(subject[:category]).to eql 'Baby Products'
      end

      it 'returns the product dimensions' do
        expect(subject[:dimensions]).to eql '4.3 x 0.4 x 7.9 inches'
      end

      it 'returns the product rank' do
        expect(subject[:rank]).to eql '#34 in Baby'
      end
    end
  end

  describe '.get_product_info', :vcr do
    context 'for B07NYN8ZLL' do
      subject { Scraper.get_product_info('B07NYN8ZLL') }

      it 'returns the product name' do
        expect(subject[:name]).to eql 'HoveBeaty Artificial Tulips Bridal Wedding Festival Decor Bouquet Real Touch PU Flower Bouquet Pack of 20 (Rose Red)'
      end

      it 'returns the product category' do
        expect(subject[:category]).to eql 'Home & Kitchen'
      end

      it 'returns the product dimensions' do
        expect(subject[:dimensions]).to eql '13 x 8.5 x 3.2 inches'
      end

      it 'returns the product rank' do
        expect(subject[:rank]).to eql '#722,405 in Home & Kitchen'
      end
    end
  end

  describe '.get_product_info', :vcr do
    context 'for B07NZ85Z67' do
      subject { Scraper.get_product_info('B07NZ85Z67') }

      it 'returns the product name' do
        expect(subject[:name]).to eql 'LÍLLÉbaby The Complete All Seasons SIX-Position, 360° Ergonomic Baby & Child Carrier, Shibori Sky - Cotton'
      end

      it 'returns the product category' do
        expect(subject[:category]).to eql 'Baby Products'
      end

      it 'returns the product dimensions' do
        expect(subject[:dimensions]).to eql '11.8 x 9.8 x 7.2 inches'
      end

      it 'returns the product rank' do
        expect(subject[:rank]).to eql '#5,220 in Baby'
      end
    end
  end

  describe '.get_product_info', :vcr do
    context 'for B07KPN9TNY' do
      subject { Scraper.get_product_info('B07KPN9TNY') }

      it 'returns the product name' do
        expect(subject[:name]).to eql 'Sony PlayStation 2 Console - Black (Renewed)'
      end

      it 'returns the product category' do
        expect(subject[:category]).to eql 'Video Games'
      end

      it 'returns the product dimensions' do
        expect(subject[:dimensions]).to eql '19 x 12 x 8 inches'
      end

      it 'returns the product rank' do
        expect(subject[:rank]).to eql '#1,282 in Video Games'
      end
    end
  end
end
