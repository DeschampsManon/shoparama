class ProductTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :brand_id
  end
end
