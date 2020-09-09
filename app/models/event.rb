class Event < ApplicationRecord
  # belongs_to :creator, class_name: 'User'
  # has_many :guests, class_name: "User"
  belongs_to :user
  has_many :invites
  has_many :attendees, through: :invites, source: 'user'
end
