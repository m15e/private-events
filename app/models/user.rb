class User < ApplicationRecord
  # has_many :host_events, foreign_key: 'host_id', class_name: 'Event'
  # has_many :guest_events, foreign_key: 'guest_id', class_name: 'Event'

  has_many :posts
end
