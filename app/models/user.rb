class User < ApplicationRecord
    has_secure_password

    validates_uniqueness_of :email, :message => "Email already exists. Login here!"
    validates_presence_of :email, :message => "Please include an email."

    validates_uniqueness_of :username, :message => "Username already exists. Please login or pick a different username."
    validates_presence_of :username, :mesage => "Please include a username."
    
    has_many :posts
    has_many :comments
    has_many :user_tags
    has_many :tags, through: :user_tags
end
