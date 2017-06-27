class AddTitleToCharts < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_block_charts, :title, :string
  end
end
