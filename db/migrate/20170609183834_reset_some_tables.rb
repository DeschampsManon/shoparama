class ResetSomeTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :categories
    drop_table :categorizations
    drop_table :products
  end
end
