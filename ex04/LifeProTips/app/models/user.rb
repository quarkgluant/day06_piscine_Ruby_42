class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
  has_many :votes, through: :posts
  validates :name, presence: true, uniqueness: true, on: :create
  validates :email, presence: true, uniqueness: true, on: :create
  validates :password, length: { minimum: 8 }, on: :create
  before_save { self.email = email.downcase }
  before_save { self.name = name.downcase }
end
