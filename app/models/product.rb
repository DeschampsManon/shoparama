class Product < ApplicationRecord
  has_many :product_sellers
  belongs_to :brand, optional: true
end
