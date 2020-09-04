class Event < ApplicationRecord
  # belongs_to :host, class_name: "User"
  # has_many :guests, class_name: "User"
  belongs_to :user
end
