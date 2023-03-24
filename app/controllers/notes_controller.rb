class NotesController < ApplicationController
  before_action :set_note, only: %i[edit update]

  def index
    @notes = Note.order position: :asc
  end

  def new
    @note = Current.user.notes.build
    @note.position = Current.user.notes.count + 1
  end

  def create
    @note = Current.user.notes.build note_params
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

  def reorder
    @note = Current.user.notes.find_by position: params[:old_position]
    @note.insert_at params[:new_position]

    head :ok
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :description, :position)
  end
end