require 'sinatra'
require 'sinatra/activerecord'
require_relative './models/User'
require_relative './models/Post'
require_relative './models/Tag'
require_relative './models/Post_Tag'

set :database, {adapter: 'postgresql', database: 'rumbler'}

get '/' do
    erb :index
end

get '/:page' do
    case params[:page]
    when 'login' || 'signup'
        erb :login
    when 'faq'
        erb :faq
    when 'search'
        erb :search
    else
       puts 'that page does not exist' 
    end
end


