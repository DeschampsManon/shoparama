class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/assets/no_image.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :favorites , through: :favorite_products, source: :product_seller
  has_many :favorite_products

  validate :first_name
  validate :last_name

  def self.current_user
    Thread.current[:user]
  end

  def self.current_user=(user)
    Thread.current[:user] = user
  end
end
