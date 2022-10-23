class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
    
  validates :username, presence: true

  has_many :tickets, foreign_key: :attendee_id, dependent: :destroy
  has_many :attended_events, through: :tickets, source: :event
  has_many :organized_events, foreign_key: :organizer_id, class_name: 'Event', dependent: :destroy

  default_scope { order(:username) }
end
