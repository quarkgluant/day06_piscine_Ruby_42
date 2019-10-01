class Post < ActiveRecord::Base
  belongs_to :user
  validates :title, uniqueness: true, length: { minimum: 3 }, on: :create
  delegate :name, to: :user, prefix: true
end
