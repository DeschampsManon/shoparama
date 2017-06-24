class AddDashboardFields < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_dashboards, :nb_users, :integer
    add_column :admin_dashboards, :nb_products, :integer
    add_column :admin_dashboards, :nb_login, :integer
    add_column :admin_dashboards, :nb_products_amazon, :integer
    add_column :admin_dashboards, :nb_products_ebay, :integer
  end
end