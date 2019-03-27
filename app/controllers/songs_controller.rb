Skip to content
 
Search or jump to…

Pull requests
Issues
Marketplace
Explore
 
@cbronzo Sign out
14
0 801 learn-co-students/rails-sidekiq-lab-v-000
 Code  Issues 3  Pull requests 809  Projects 0  Insights
rails-sidekiq-lab-v-000/app/controllers/songs_controller.rb
@bethurban bethurban Done.
f3da6f3 20 days ago
@scottcreynolds @bethurban
59 lines (45 sloc)  859 Bytes
    
class SongsController < ApplicationController

  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
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

  def upload
    SongsWorker.perform_async(params["file"].path)
    redirect_to songs_path
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
