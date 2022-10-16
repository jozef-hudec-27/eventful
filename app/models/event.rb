class Event < ApplicationRecord
  belongs_to :organizer, class_name: 'User'

  has_many :tickets
  has_many :attendees, through: :tickets
end
