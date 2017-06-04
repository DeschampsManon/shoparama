class AddForeignKey < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :brand_id, :integer
    add_column :product_sellers, :product_id, :integer
  end
end
