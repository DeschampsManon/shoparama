class AddDashboardFields < ActiveRecord::Migration[5.0]
  def change
    add_column :dashboards, :nb_users, :integer
    add_column :dashboards, :nb_products, :integer
    add_column :dashboards, :nb_login, :integer
  end
end
