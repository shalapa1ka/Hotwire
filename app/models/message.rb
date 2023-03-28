# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :body, presence: true, length: { maximum: 1000 }
end
