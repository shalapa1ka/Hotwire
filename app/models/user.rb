# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :email_verification_tokens, dependent: :destroy
  has_many :password_reset_tokens, dependent: :destroy

  has_many :sessions, dependent: :destroy

  has_many :notes, dependent: :destroy
  has_many :room_members, dependent: :destroy
  has_many :rooms, through: :room_members
  has_many :messages, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_messages, through: :likes, source: :message

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 3 }

  before_validation if: -> { email.present? } do
    self.email = email.downcase.strip
  end

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).destroy_all
  end

  def admin?
    true
  end

  def member_of?(room)
    room.users.include?(self)
  end

  def liked?(msg)
    liking_messages.include?(msg)
  end
end
