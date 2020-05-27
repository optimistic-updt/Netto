require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry' if development?

require_relative 'models/user.rb'
require_relative 'models/card.rb'

enable :sessions

get '/' do
  erb :landing
end


get '/user/new' do
  erb :'/user/user_new'
end


post '/user' do
  create_user(params[:email], params[:pw])
  session[:user_id] = get_user_by_email(params[:email])["id"]
  redirect '/index'
end


get '/user/login' do
  erb :'/user/user_login'
end


post '/user/login' do
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

  if user == nil
    redirect '/'
  else
  cards = all_cards_for_user(user["id"])

  erb :'cards/index', locals: {
    user: user,
    cards: cards
  }
  end
end


get '/show/:id' do
  card = get_card_by_id(params[:id])
  user = get_user_by_id(session[:user_id])
  
  # the card as a number as source
    # we want a name
  if card["source"] == nil
    card["source"] = "No-one"
  else
    knows_card = get_card_by_id(card["source"])
    card["source"] = knows_card["name"]
  end  
  
  # show the targets
  # find all the cards that have source is this card's id
  targets = get_targets(params[:id])
  

  erb :'/cards/show', locals: {
    card: card,
    user: user,
    source_card: knows_card,
    targets: targets
  }
end


get '/card/:id/edit' do
  card = get_card_by_id(params[:id])
  user = get_user_by_id(session[:user_id])

  erb :'/cards/edit', locals: {
    card: card,
    user: user
  }
end


patch '/card' do
  edit_card(params[:id], 
    params[:name],
    params[:image],
    params[:workplace],
    params[:job],
    params[:met],
    params[:source],
    params[:skills],
    params[:quality],
    params[:notes],
    )

  redirect "/index"
end


get '/card/new' do
  user = get_user_by_id(session[:user_id])

  erb :'cards/new', locals: {
    user: user
  }
end


post'/card' do
  create_card(
    params[:name],
    params[:image],
    params[:workplace],
    params[:job],
    params[:met],
    params[:source],
    params[:skills],
    params[:quality],
    params[:notes],
    session[:user_id]
  )

  redirect '/index'  
end


get '/card/:id/delete' do
  card = get_card_by_id(params[:id])
  user = get_user_by_id(session[:user_id])

  erb :'cards/delete', locals: {
    card: card,
    user: user
  }
end


delete '/card' do
  delete_card(params[:id])
  redirect "/index"
end


get '/search' do
  results = search(params[:search])
  user = get_user_by_id(session[:user_id])


  erb :'/cards/search_results', locals: {
    results: results,
    user: user,
    search_term: params[:search]
  } 
end