class ProductOption < ApplicationRecord
  has_many :products , :through => :product_option_details
  has_many :product_option_details
end
