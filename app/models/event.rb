class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :invites, dependent: :destroy
  has_many :attendees, through: :invites, source: 'user', dependent: :destroy
  accepts_nested_attributes_for :invites

  scope :future, -> { where('time >= ?', DateTime.now).order(time: :desc) }
  scope :past, -> { where('time < ?', DateTime.now).order(time: :desc) }

  validates :location, :title, :description, :time, presence: true
end
