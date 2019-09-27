class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true, uniqueness: true, on: :create
  validates :email, presence: true, uniqueness: true, on: :create
  validates :password, length: { minimum: 8 }, on: :create
end
