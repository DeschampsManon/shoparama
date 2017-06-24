class AddBannerToUsers < ActiveRecord::Migration[5.0]
  def up
    change_table :users do |t|
      t.attachment :cover_banner
    end
  end

  def down
    drop_attached_file :users, :cover_banner
  end
end
