# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:albums)    
  end

  get '/albums/new' do
    return erb(:new_album)
  end

  post '/albums' do
    if invalid_request_parameters_albums?
      status 400

      return ''
    end

    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]
    repo.create(new_album)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    return erb(:artists)
  end

  get '/artists/new' do
    return erb(:new_artist)
  end

  post '/artists' do
    if invalid_request_parameters_artists?
      status 400

      return ''
    end

    repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]
    repo.create(new_artist)

    repo = ArtistRepository.new
    @artists = repo.all
    return "Hello"
  end

  def invalid_request_parameters_artists?
    return true if params[:name] == nil || params[:genre] == nil
    return true if params[:name] == "" || params[:genre] == ""
    return false
  end

  def invalid_request_parameters_albums?
    return true if params[:title] == nil || params[:release_year] == nil
    return true if params[:title] == "" || params[:release_year] == ""
    return false
  end

  get "/albums/:id" do
    @id = params[:id]
    repo = AlbumRepository.new
    artrepo = ArtistRepository.new
    foundalbum = repo.find(@id)
    @title = foundalbum.title
    @release_year = foundalbum.release_year
    @artist_id = foundalbum.artist_id 
    artist_object = artrepo.find(@artist_id)
    @artist = artist_object.name
    return erb(:index)
  end

  get "/artists/:id" do
    @id = params[:id]
    repo = ArtistRepository.new
    foundartist = repo.find(@id)
    @name = foundartist.name
    @genre = foundartist.genre
    return erb(:find_artist)
  end
end