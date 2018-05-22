require "bcrypt"
class User < ActiveRecord::Base
    include BCrypt

    has_secure_password
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :username, presence: true
    validates :email, presence: true
end
