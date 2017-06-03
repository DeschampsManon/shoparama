class ProductOptionDetail < ApplicationRecord
  belongs_to :options
  belongs_to :product_options
end
