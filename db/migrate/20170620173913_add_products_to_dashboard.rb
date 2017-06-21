class AddProductsToDashboard < ActiveRecord::Migration[5.0]
  def change
    add_column :dashboards, :nb_products_amazon, :integer
    add_column :dashboards, :nb_products_ebay, :integer
  end
end
