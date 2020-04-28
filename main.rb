require 'sinatra'
require 'sinatra/reloader'
require 'pry'

require_relative 'models/user.rb'
require_relative 'models/card.rb'

enable :sessions

get '/' do
  erb :landing
end

get '/user/new' do
  erb :user_new
end

post '/user' do
  create_user(params[:email], params[:pw])

  session[:user_id] = get_user_by_email(params[:email])["id"]

  redirect '/index'
end
##### this is where you are
get '/index' do
  "logged in as #{ session[:user_id] }"

  erb :index
end



