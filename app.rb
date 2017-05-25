require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:firstdb.sqlite3"
set :sessions, true


require './models'

get '/' do 
 	@blogs = Blog.all
 	erb :index
end

get '/profile' do
	@user = User.find(session[:user_id])
	@blogs = @user.blogs
	erb :index
end

post '/profile' do
	user = User.find(session[:user_id])
	Blog.create(title: params[:title], category: params[:category], content: params[:content])
	redirect "/"	
end

post '/new_user' do
	User.create(username: params[:username], password: params[:password], city: params[:city], school: params[:school])
	redirect "/success"
end

get '/myspace' do
	@user = User.find(session[:user_id])
	erb :myspace
end

get '/login' do
	erb :login
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

