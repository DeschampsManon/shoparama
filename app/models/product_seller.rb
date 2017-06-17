class ProductSeller < ApplicationRecord
  has_many :categories , through: :categorizations
  has_many :categorizations
  has_many :favorited_by , through: :favorite_products, source: :user
  has_many :favorite_products
  belongs_to :product
end
