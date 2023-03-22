class Note < ApplicationRecord
  belongs_to :user

  acts_as_list sequential_list: false

  validates :title, presence: true
  validates :description, presence: true
  validates :position, uniqueness: { scope: :user_id }
end