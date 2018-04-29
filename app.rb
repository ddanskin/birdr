require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'

require "./models/user"
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

# show default index
get '/' do
    if logged_in?
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

# if logged in, show post page, otherwise show signin page
get '/post' do
    if logged_in?
        erb :edit_post
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
    @current_user = User.new(user_params)
    @current_user.password = user_params[:password]
    @current_user.save!
    session[:user_id] = @current_user.id
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
    if logged_in?
        erb :create_profile
    else
        erb :signin
    end
end

post "user/profile/create" do
    profile_params = params[:profile]
    profile = Profile.create(profile_params)
    profile.user_id = @current_user.id
    profile.save!
    redirect "/user/post/create"
end

# show form for editing current user's profile
get "/user/profile/edit" do
    if logged_in?
        erb :edit_profile
    else
        erb :signin
    end
end

# gets requested user profile and shows appropriate profile view
get "/user/profile/:username" do
    requested_profile = User.find_by(username: params[:username])
    @all_posts = Post.where(user_id: requested_profile.id)
    puts requested_profile
    if requested_profile
        if current_user.username == params[:username]
            current_user = requested_profile
            erb :user_profile
        else
            @other_user = requested_profile
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
