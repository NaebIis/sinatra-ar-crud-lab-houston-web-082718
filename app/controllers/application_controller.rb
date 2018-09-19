
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    "Hello, World!"
  end

  get '/posts' do 
    @posts = Post.all
    
    erb :'posts/index'
  end

  get '/posts/new' do
    erb :'posts/new'
  end
  
  
  get '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    
    erb :'posts/show'
  end
  
  post '/posts' do 
    Post.create(params)
    redirect '/posts'
  end

  get '/posts/:id/edit' do

    @post = Post.find_by_id(params[:id])

    erb :'posts/edit'
  end


  patch '/posts/:id' do
    @post = Post.find(params[:id])

    @post.name=(params[:name])
    @post.content=(params[:content])
    @post.save

    redirect "/posts/#{@post.id}"
  end

  delete '/posts/:id' do
    @post = Post.find(params[:id])

    @post.destroy

    redirect '/posts'
  end

end
