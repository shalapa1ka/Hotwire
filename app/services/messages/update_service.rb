# frozen_string_literal: true

module Messages
  class UpdateService < ::ApplicationService
    def initialize(message, params)
      super
      @object = message
      @params = params
    end

    def call
      tx_and_commit do
        @object.update @params
      end

      super
    end

    private

    def post_call
      broadcast_later "room_#{@object.room_id}",
                      'messages/updated',
                      locals: { message: @object }
    end
  end
end
