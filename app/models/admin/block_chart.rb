class Admin::BlockChart < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :title, presence: true
end
