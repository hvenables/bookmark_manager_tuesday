require 'sinatra/base'

class link < Sinatra::Base
  get '/' do
    'Hello link!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
