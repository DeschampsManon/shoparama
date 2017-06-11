class BrandIdForeignKey < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :brand_id, :integer, :null => true, foreign_key: true
  end
end
