class NotesController < ApplicationController
  before_action :set_note, only: %i[edit update]

  def index
    @notes = Note.order position: :asc
  end

  def new
    @note = current_user.notes.build
    @note.position = current_user.notes.count + 1
  end

  def create
    @note = current_user.notes.build note_params
    if @note.save
      flash.now[:success] = 'Note was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @note.update note_params
      flash.now[:success] = 'Note was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :description, :position)
  end
end