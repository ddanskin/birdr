require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'

require "./models/user"
require "./models/profile"
require "./models/post"

require_relative "helpers"

include BCrypt

set :database, {adapter: 'postgresql', database: 'birdr'}

configure do
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
end

# make sure user is signed in before showing user profiles
before '/user/profile/*' do
    if current_user == nil
        redirect "/user/signin"
    end
end

# make sure user is signed in before showing user profiles
before '/user/post/*' do
    if current_user == nil
        redirect "/user/signin"
    end
end

# show default index
get '/' do
    if logged_in?
        @recent_posts = Post.all.order("created_at DESC").limit(20)
        erb :home
    else
        erb :index
    end
end

# if logged in, show search page, otherwise show signin page
get '/search' do
    if logged_in?
        erb :search
    else
        erb :signin
    end
end

# show sign up page
get '/user/signup' do
    erb :signup
end

# use params in signup form to create a new user and log them in
post "/user/signup" do
    puts params[:user]
    user_params = params[:user]
    current_user = User.new(user_params)
    current_user.password = user_params[:password]
    current_user.save!
    session[:user_id] = current_user.id
    redirect "/user/profile/create"
end

# show sign in page
get "/user/signin" do
    erb :signin
end

# authenticate user and start session
post "/user/signin" do
    user_params = params[:user]
    user = User.find_by(username: user_params[:username])
    if user.authenticate(user_params[:password])
        session[:user_id] = user.id
        redirect "/"
    else
        redirect "/user/signin"
    end
end

# show form for editing current user's profile
get "/user/profile/create" do
    @profile_default ={
        city: "city",
        state: "state",
        country: "country",
        about: "I'm new to birding."
    }
    erb :create_profile
end

# create user profile
post "/user/profile/create" do
    profile_params = params[:profile]
    profile = Profile.create(profile_params)
    profile.user_id = current_user.id
    profile.save!
    redirect "/user/post/create"
end

# show form for editing current user's profile
get "/user/profile/edit" do
    @profile = Profile.find_by(user_id: current_user.id)
    erb :edit_profile
end

# edit user profile
put "/user/profile/edit" do
    profile_params = params[:profile]
    @profile = Profile.find_by(user_id: current_user.id)
    @profile.update(profile_params)
    redirect '/'
end

# show form for creating first post
get "/user/post/create" do
    @post_default = {
        image: "https://tinyurl.com/ycohj55h",
        text: "My first post!",
        tags: "firstpost,exoticbird,purple"
    }
    erb :create_post
end

# create new  post
post "/user/post/create" do
    post_params = params[:post]
    new_post = Post.create(post_params)
    new_post.user_id = current_user.id
    new_post.save!
    redirect "/"
end

# show form for editing post
get "/user/post/:id/edit" do
    @post_default = Post.find_by(id: params[:id])
    erb :edit_post
end

# edit existing post
put "/user/post/:id/edit" do
    post_params = params[:post]
    post = Post.find_by(id: params[:id])
    post.update(post_params)
    post.save!
    redirect "/"
end

# delete user post
delete '/user/post/:id/delete' do
    Post.destroy(params[:id])
    redirect '/'
end

# show post by id number
get "/user/post/:id" do
    @post = Post.find(params[:id])
    erb :post
end

# gets requested user profile and shows appropriate profile view
get "/user/profile/:username" do
    requested_profile = User.find_by(username: params[:username])
    @all_posts = Post.where(user_id: requested_profile.id).order("created_at DESC").limit(20)
    puts requested_profile
    if requested_profile
        if current_user.username == params[:username]
            erb :user_profile
        else
            @other_user = requested_profile
            @other_profile = Profile.find_by(user_id: requested_profile.id)
            @posts = all_user_posts(requested_profile.id).order("created_at DESC").limit(20)
            erb :other_profile
        end
    else
        @requested_page = "..user/profile/#{params[:username]}"
        erb :page_does_not_exist
    end
end

# end current user's session
get "/signout" do
    session.clear
    redirect '/user/signin'
end

# delete user account
delete '/user/:id' do
    User.destroy(params[:id])
    Profile.find_by(user_id: params[:id]).destroy
    Post.where(user_id: params[:id]).destroy_all
    session.clear
    redirect '/'
end
