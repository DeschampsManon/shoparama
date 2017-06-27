class CreateUserKeywords < ActiveRecord::Migration[5.0]
  def change
    create_table :user_keywords do |t|
      t.string :name
      t.integer :counter
      t.timestamps
    end
  end
end
