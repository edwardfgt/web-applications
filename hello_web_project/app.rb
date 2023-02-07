require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  post '/submit' do
    name = params[:name]
    message = params[:message]
    return "Thanks #{name}, you sent this message: #{message}"
  end

  get '/names' do
    return "Julia, Mary, Karim"
  end

  post '/sort-names' do
    names = params[:names]
    name_array = names.split(",")
    sorted_array = name_array.sort
    return sorted_array.join(",")
  end

  get '/hello' do
    return erb(:index)
  end
end