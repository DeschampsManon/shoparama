class Category < ApplicationRecord
  has_many :product_sellers , :through => :categorizations
  has_many :categorizations
end
