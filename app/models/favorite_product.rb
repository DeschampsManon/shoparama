class FavoriteProduct < ApplicationRecord
  belongs_to :product_seller
  belongs_to :user
end
