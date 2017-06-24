class RenameTables < ActiveRecord::Migration[5.0]
  def change
    remove_column :dashboards, :job_date
  end

  def self.up
    rename_table :dashboards, :admin_dashboards
    rename_table :visits, :user_login
  end

  def self.down
    rename_table :admin_dashboards, :dashboards
    rename_table :user_login, :visits
  end
end
