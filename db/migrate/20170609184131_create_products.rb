class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :reference
      t.timestamps
    end
    add_reference :products, :brand, foreign_key: true
  end
end
