class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
    
  validates :username, presence: true
end
