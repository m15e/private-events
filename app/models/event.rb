class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :invites
  has_many :attendees, through: :invites, source: 'user'
  accepts_nested_attributes_for :invites

  scope :future, -> { where('time >= ?', DateTime.now).order(time: :desc) }
  scope :past, -> { where('time < ?', DateTime.now).order(time: :desc) }
end
