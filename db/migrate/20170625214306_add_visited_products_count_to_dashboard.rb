class AddVisitedProductsCountToDashboard < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_dashboards, :nb_products_amazon_visited, :integer
    add_column :admin_dashboards, :nb_products_ebay_visited, :integer
  end
end
