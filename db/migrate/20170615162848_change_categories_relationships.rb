class ChangeCategoriesRelationships < ActiveRecord::Migration[5.0]
  def change
    add_column :categorizations, :product_seller_id, :integer
    remove_column :categorizations, :product_id, :integer
  end
end
