# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'Turbo', current_user&.email
    end

    protected

    def find_verified_user
      User.find(Session.find(cookies.signed[:session_token])&.user_id)
    end
  end
end
