class NotesController < ApplicationController
  before_action :must_be_logged_in

  def create
    @note = Note.new(note_params)
    if @note.save
      @track = @note.track
      redirect_to track_note_url(@note)
    else
      flash[:errors] = @note.errors.full_messages
      @track = Track.find(params[:track_id])
      fail
      redirect_to new_track_note_url(@track)
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
  end

  def edit
    @note = Note.find(params[:id])
    render :edit
  end

  # def index
  #   @notes = ...
  #   render :index
  # end

  def new
    @track = Track.find(params[:track_id])
    render :new
  end

  # def show
  #   @note = Note.find(params[:id])
  #   @track = Track.find(@note.track_id)
  #   @user = Track.find(@note.user_id)
  #   render :show
  # end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      @track = @note.track
      redirect_to track_url(@track)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to edit_track_note_url
    end
  end

  private

    def note_params
      params.require(:note).permit(:body, :user_id, :track_id)
    end

end
