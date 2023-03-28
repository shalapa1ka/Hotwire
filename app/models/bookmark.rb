# frozen_string_literal: true

class Bookmark < ApplicationRecord
  validates :title, presence: true
  belongs_to :folder
end
