require "./models/user"
require "./models/profile"
require "./models/post"
require "./models/tag"
require "./models/post_tag"
require_relative "helpers"

require './app'
run Sinatra::Application
