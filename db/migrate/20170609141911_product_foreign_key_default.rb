class ProductForeignKeyDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :products, :brand_id, 0
  end
end
