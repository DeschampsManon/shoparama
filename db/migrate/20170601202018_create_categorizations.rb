class CreateCategorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :categorizations do |t|
      t.integer :categorie_id
      t.integer :product_id
      t.timestamps
    end
  end
end
