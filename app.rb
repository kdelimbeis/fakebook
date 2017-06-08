require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:firstdb.sqlite3"

use Rack::Session::Cookie, :key => "rack.session"


require './models'

get '/' do 
 	@blogs = Blog.all
 	erb :index
end

post '/login' do
	user = User.where(username: params[:username]).first
	if user.password == params[:password]
		session[:user_id] = user.id
		redirect '/myspace'
	else
		redirect '/wrong'
	end
end

get '/myspace' do
	@user = User.find(session[:user_id])
	erb :myspace
end

post '/profile' do
	user = User.find(session[:user_id])
	Blog.create(title: params[:title], category: params[:category], content: params[:content], user_id: user.id)
	redirect "/"	
end

post '/new_user' do
	User.create(username: params[:username], password: params[:password], city: params[:city], school: params[:school])
	redirect "/success"
end



get '/login' do
	erb :login
end



get '/success' do
	erb :success
end

get '/wrong' do
	erb :wrong
end

post '/logout' do
	session[:user_id] = nil
	redirect '/login'
end

post '/destroy_user' do
	user = User.find(session[:user_id])
	user.destroy
	redirect '/login'
end

post '/edit_user' do
	user = User.find(session[:user_id])
	user.update(password: params[:password], city: params[:city], school: params[:school])
	redirect '/myspace'
end

get '/users'  do
@users = User.all
erb :users
end

get '/users/:id' do
@user = User.find(params[:id])
@blogs = Blog.where(user_id: params[:id])
erb :user
end

