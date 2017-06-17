class UserProductRelationship < ActiveRecord::Migration[5.0]
  def change
    add_column :product_sellers, :user_id, :integer
  end
end
