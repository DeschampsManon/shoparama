class Option < ApplicationRecord
  has_many :product_options , :through => :product_option_details
  has_many :product_option_details
end
