class Product < ApplicationRecord
  has_many :categories , :through => :categorizations
  has_many :categorizations
  has_many :product_sellers
  belongs_to :brand, optional: true
end
