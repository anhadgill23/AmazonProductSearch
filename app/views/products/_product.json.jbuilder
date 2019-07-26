json.extract! product, :id, :asin, :category, :rank, :dimensions, :created_at, :updated_at
json.url product_url(product, format: :json)
