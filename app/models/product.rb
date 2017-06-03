class Product < ApplicationRecord
  has_many :product_sellers
  has_many :categories , :through => :categorizations
  has_many :categorizations
  belongs_to :brand
end
