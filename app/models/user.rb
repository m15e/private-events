class User < ApplicationRecord
  # has_many :created_events, foreign_key: 'event_id', class_name: 'Event'
  # has_many :guest_events, foreign_key: "guest_id", class_name: "Event"
  has_many :events
  has_many :invites
  has_many :attended_event, through: :invites, source: 'event'

  def upcoming_events
    self.events.where('time >= ?', DateTime.now)
  end

  def past_events
    self.events.where('time < ?', DateTime.now)
  end
end
