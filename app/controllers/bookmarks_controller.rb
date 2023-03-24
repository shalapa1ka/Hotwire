class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]
  before_action :set_folder
    def show; end

  def new
    @bookmark = @folder.bookmarks.build
  end

  def edit; end

  def create
    success, @bookmark = Bookmarks::CreateService.call @folder, bookmark_params

    if success
      flash.now[:success] = 'Bookmark created!'
    else
      render :new
    end
  end

  def update
    if @bookmark.update bookmark_params
      flash.now[:success] = "Bookmark was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @bookmark.destroy
    flash.now[:success] = "Bookmark was successfully destroyed."
  end

  private

    def set_folder
      @folder = Folder.find(params[:folder_id])
    end

    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end

    def bookmark_params
      params.require(:bookmark).permit(:title)
    end
end