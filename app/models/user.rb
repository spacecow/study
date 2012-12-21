class User < ActiveRecord::Base
  has_many :sentences

  attr_accessible :email, :name, :oauth_expires_at, :oauth_token, :provider, :uid

  include Authorization
end
