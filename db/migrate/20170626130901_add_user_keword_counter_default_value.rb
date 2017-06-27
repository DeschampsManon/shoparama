class AddUserKewordCounterDefaultValue < ActiveRecord::Migration[5.0]
  def change
    change_column :user_keywords, :counter, :integer, :default => 0

  end
end
