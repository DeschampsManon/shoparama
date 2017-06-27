class AddDefaultPresenceBlockChart < ActiveRecord::Migration[5.0]
  def change
    change_column :admin_block_charts, :presence, :boolean, :default => true
  end
end
