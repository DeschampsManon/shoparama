class AddDateToDashboard < ActiveRecord::Migration[5.0]
  def change
    add_column :dashboards, :job_date, :date
  end
end
