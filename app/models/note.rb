class Note < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  validates :position, uniqueness: { scope: :user_id }
end