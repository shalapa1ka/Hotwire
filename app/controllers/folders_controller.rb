# frozen_string_literal: true

class FoldersController < ApplicationController
  before_action :set_folder!, only: %i[show edit update destroy]
  def index
    @folders = Folder.order created_at: :desc
  end

  def show
    @bookmarks = @folder.bookmarks.order created_at: :desc
  end

  def new
    @folder = Folder.new
  end

  def create
    @folder = Folder.new folder_params
    if @folder.save
      flash.now[:success] = 'Folder created!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @folder.update folder_params
      redirect_to folders_path
    else
      render :edit
    end
  end

  def destroy
    @folder.destroy
    flash.now[:success] = 'Folder deleted!'
  end

  private

  def set_folder!
    @folder = Folder.find params[:id]
  end

  def folder_params
    params.require(:folder).permit :title, :description
  end
end
