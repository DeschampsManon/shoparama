class Category < ApplicationRecord
  has_many :product_sellers , :through => :categorizations
  has_many :categorizations

  translates :name, :fallbacks_for_empty_translations => true

  Globalize.fallbacks = {:fr => [:fr, :en], :en => [:en, :fr]}

  validates :name, presence: true, uniqueness: true

end

