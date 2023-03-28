# frozen_string_literal: true

module Api
  class ImagesController < ApplicationController
    def update
      @image = Image.find(params[:id])
      @image.update(image_params)
      head :ok
    end

    private

    def image_params
      params.require(:image).permit(:title)
    end
  end
end
