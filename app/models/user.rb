class User < ActiveRecord::Base
  has_secure_password

  has_many :sentences

  attr_accessible :email, :password, :name, :oauth_expires_at, :oauth_token, :provider, :uid
end
