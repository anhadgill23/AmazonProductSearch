class Product < ApplicationRecord
  validates :asin, presence: true, length: { is: 10 }
end
