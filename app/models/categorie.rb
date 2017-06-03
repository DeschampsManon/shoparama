class Categorie < ApplicationRecord
  belongs_to :category, foreign_key: :parent_id
  has_many :products , :through => :categorizations
  has_many :categorizations
end
