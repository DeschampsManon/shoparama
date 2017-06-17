class CreateFavoriteProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_products do |t|
      t.integer :user_id
      t.integer :product_seller_id
      t.timestamps
    end
    remove_column :product_sellers, :user_id, :integer
  end
end
