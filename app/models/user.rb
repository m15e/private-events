class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :invites, dependent: :destroy
  has_many :attended_events, through: :invites, source: 'event', dependent: :destroy

  validates :name, :email, presence: true
end
