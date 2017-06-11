class NullableBrandId < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :brand_id, :integer, :null => true
  end
end
