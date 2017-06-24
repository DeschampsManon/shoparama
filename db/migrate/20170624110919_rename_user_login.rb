class RenameUserLogin < ActiveRecord::Migration[5.0]
  def change
    rename_table :user_login, :user_logins
  end
end
