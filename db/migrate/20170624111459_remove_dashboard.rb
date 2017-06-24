class RemoveDashboard < ActiveRecord::Migration[5.0]
  def change
    drop_table :admin_dashboards
  end
end
