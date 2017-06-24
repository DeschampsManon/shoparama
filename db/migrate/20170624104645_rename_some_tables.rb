class RenameSomeTables < ActiveRecord::Migration[5.0]
  def change
    rename_table :dashboards, :admin_dashboards
  end
end
