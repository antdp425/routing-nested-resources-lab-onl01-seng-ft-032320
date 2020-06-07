class SongsController < ApplicationController
  def index
    @artist = Artist.find_by(id: params[:artist_id])
      if params[:artist_id] && @artist
        @songs = @artist.songs
      elsif !params[:artist_id].present?
        @songs = Song.all
      else
        redirect_to artists_url, alert: "Artist not found"
      end
  end

  def show
    @song = Song.find_by(id: params[:id])
    if params[:artist_id] && @song
      @song
    elsif params[:artist_id] && !@song
      redirect_to artist_songs_url(params[:artist_id]), alert: "Song not found"
    else
      @song
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

