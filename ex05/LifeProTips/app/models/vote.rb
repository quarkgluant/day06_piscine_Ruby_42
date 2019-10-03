class Vote < ActiveRecord::Base
  # belongs_to :votant, class_name: :user
  belongs_to :user
  belongs_to :post
end
