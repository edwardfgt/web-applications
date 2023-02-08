require 'sinatra/base'
require "sinatra/reloader"

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  def validate_input(input)
    if input.include?(',./<>!@£$%^&*-')
      return true
    else
      false
    end
  end

  post '/hello' do

    @name = params[:name]
    return erb(:error) if validate_input(@name)
    return erb(:hello)
  end
end
