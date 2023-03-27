module Messages
  class UpdateService < ::ApplicationService
    def initialize(message)
      super
      @object = message
    end

    def call
      tx_and_commit do
        @object.touch
      end

      super
    end

    private

    def post_call
      broadcast_later "room_#{@params[:room_id]}",
                      'messages/updated',
                      locals: { message: @object }
    end
  end
end