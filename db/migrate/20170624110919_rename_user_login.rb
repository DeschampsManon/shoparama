class RenameUserLogin < ActiveRecord::Migration[5.0]
  def change
    rename_table :user_visit, :user_logins
  end
end
