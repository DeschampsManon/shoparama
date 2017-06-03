class CreateProductOptionDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :product_option_details do |t|
      t.integer :product_option_id
      t.integer :option_id
      t.timestamps
    end
  end
end
