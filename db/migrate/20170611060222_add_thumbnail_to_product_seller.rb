class AddThumbnailToProductSeller < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :thumbnail
    add_column :product_sellers, :thumbnail, :string
  end
end
