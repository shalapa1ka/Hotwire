class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]
  before_action :set_folder, only: [:new, :create, :edit]
    def show; end

  def new
    @bookmark = @folder.bookmarks.new
  end

  def edit; end

  def create
    @bookmark =  @folder.bookmarks.new(bookmark_params)
    if @bookmark.save
      flash.now[:success] = "Bookmark was successfully created."
    else
      render :new
    end
  end

  def update
    if @bookmark.update bookmark_params
      redirect_to folders_path
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