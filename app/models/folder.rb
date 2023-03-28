# frozen_string_literal: true

class Folder < ApplicationRecord
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
end
