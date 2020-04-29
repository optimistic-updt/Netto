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


get '/user/login' do
  erb :user_login
end


post '/user/login' do
  # find and match the user
  user = get_user_by_email(params[:email])

  if user && BCrypt::Password.new(user["pw_digest"]) == params[:pw]
    session[:user_id] = user["id"]
    redirect '/index'
  else
    redirect '/user/login'
  end
end


delete '/session' do
  session[:user_id] = nil
  redirect '/'
end


get '/index' do
  user = get_user_by_id(session[:user_id])
  cards = all_cards_for_user(user["id"])

  erb :index, locals: {
    user: user,
    cards: cards
  }
end


get '/show/:id' do
  card = get_card_by_id(params[:id])
  erb :show, locals: {
    card: card
  }
end


get '/card/:id/edit' do
  card = get_card_by_id(params[:id])
  erb :edit, locals: {
    card: card
  }
end


patch '/card' do
  edit_card(params[:id], 
    params[:name],
    params[:image],
    params[:workplace],
    params[:job],
    params[:met],
    params[:relationship],
    params[:skills],
    params[:quality],
    params[:notes],
    )

  redirect "/index"
end


get '/card/new' do
  erb :new
end


post'/card' do
  create_card(
    params[:name],
    params[:image],
    params[:workplace],
    params[:job],
    params[:met],
    params[:relationship],
    params[:skills],
    params[:quality],
    params[:notes],
    session[:user_id]
  )

  redirect '/index'  
end


get '/card/:id/delete' do
  card = get_card_by_id(params[:id])
  erb :delete, locals: {
    card: card
  }
end


delete '/card' do
  delete_card(params[:id])
  redirect "/index"
end