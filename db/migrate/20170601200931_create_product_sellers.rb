class CreateProductSellers < ActiveRecord::Migration[5.0]
  def change
    create_table :product_sellers do |t|
      t.string :website
      t.string :url
      t.string :price
      t.string :name
      t.timestamps
    end
  end
end
