require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  context 'GET #show' do
    it 'returns a success response' do
      product = Product.create(
        asin: 'B07PX28YBK',
        name: 'SanDisk 400GB Ultra microSDXC UHS-I Memory Card with Adapter',
        category: 'Electronics',
        dimensions: '0 x 0.6 x 0.4 inches',
        rank: '#124 in Cell Phones & Accessories'
      )
      get :show, params: { id: product.to_param }
      expect(response).to be_success
    end
  end
end
