class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  # has_many :guests, class_name: "User"
  # belongs_to :user as :creator
end
