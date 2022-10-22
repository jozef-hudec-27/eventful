class Event < ApplicationRecord
  validates :name, :description, :location, :ticket_price, presence: true
  validates :ticket_price, inclusion: 0..500

  belongs_to :organizer, class_name: 'User'

  has_many :tickets, dependent: :destroy
  has_many :attendees, through: :tickets
end
