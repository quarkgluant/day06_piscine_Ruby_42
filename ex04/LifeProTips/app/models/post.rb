class Post < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  validates :title, uniqueness: true, length: { minimum: 3 }, on: :create
  delegate :name, to: :user, prefix: true
end
