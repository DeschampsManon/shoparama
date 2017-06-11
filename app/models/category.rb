class Category < ApplicationRecord
  has_many :products , :through => :categorizations
  has_many :categorizations
end
