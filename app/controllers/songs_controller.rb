class SongsController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/songs' do
    erb :songs
  end

  

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    @genres = @song.genres
    #binding.pry
    erb :song_slug
  end

  get '/songs/new' do
    erb :new_song
  end

  post '/songs' do
    artist = Artist.find_by(name: params[:artist])
    if artist == nil
      artist = Artist.create(name: params[:artist])
    end
    song = Song.create(name: params[:name], artist: artist)
    redirect to "/songs/#{song.slug}"
  end

end
