class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :room_members, dependent: :destroy
  has_many :users, through: :room_members, source: :user
end
