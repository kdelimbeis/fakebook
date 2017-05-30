require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:firstdb.sqlite3"
set :sessions, true


require './models'

get '/' do 
 	@blogs = Blog.all
 	erb :index
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

get '/user28' do
	@user = User.find(28)
	@blogs = Blog.where(user_id: params[:user_id]=28)
	erb :user28
end
get '/user29' do
	@user = User.find(29)
	@blogs = Blog.where(user_id: params[:user_id]=29)
	erb :user29
end
get '/user30' do
	@user = User.find(30)
	@blogs = Blog.where(user_id: params[:user_id]=30)
	erb :user30
end
get '/user31' do
	@user = User.find(31)
	@blogs = Blog.where(user_id: params[:user_id]=31)
	erb :user31
end

get '/user32' do
	@user = User.find(32)
	@blogs = Blog.where(user_id: params[:user_id]=32)
	erb :user32
end
