require 'sinatra/base'
require_relative 'helpers'
require_relative './data_mapper_setup.rb'



class Controller < Sinatra::Base
  include Helpers

  set :views, proc { File.join(root, 'views') }

  enable :sessions
  set :sesion_secret, 'super secret'

  get '/' do
    redirect to('/links')
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    link = Link.new(url: params[:url],
                  title: params[:title])
    params[:tag].split(" ").each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect to('/links')
  end

  get '/links/new' do
    erb :'links/new'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(email: params[:email],
              password: params[:password],
              password_confirmation: params[:password_confirmation])
    session[:user_id] = user.id
    redirect to('/links')
  end
end
