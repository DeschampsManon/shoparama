class ProductSeller < ApplicationRecord
  has_many :categories , :through => :categorizations
  has_many :categorizations
  belongs_to :product
end
