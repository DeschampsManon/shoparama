class CreateAdminBlockCharts < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_block_charts do |t|
      t.string :name
      t.integer :x, default: 0
      t.integer :y, default: 0
      t.integer :width, default: 4
      t.integer :height, default: 3
      t.boolean :presence
      t.timestamps
    end
  end
end
