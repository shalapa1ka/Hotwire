class Api::ImagesController < ApplicationController
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