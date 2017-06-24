class CreateAdminDashboards < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_dashboards do |t|
      t.integer :nb_users
      t.integer :nb_products
      t.integer :nb_login
      t.integer :nb_products_amazon
      t.integer :nb_products_ebay
      t.timestamps
    end
  end
end
