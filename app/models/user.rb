class User < ActiveRecord::Base
  has_many :sentences

  attr_accessible :email, :name, :oauth_expires_at, :oauth_token, :provider, :uid

  ADMIN     = 'admin'
  GOD       = 'god'
  MEMBER    = 'member'
  MINIADMIN = 'miniadmin'
  VIP       = 'vip'
  ROLES     = [GOD,ADMIN,MINIADMIN,VIP,MEMBER]

  def role?(s) roles.include?(s.to_s) end
  def roles; ROLES.reject{|r| ((roles_mask||0) & 2**ROLES.index(r)).zero? } end

  class << self
    def authenticate_from_omniauth(auth)
      where(auth.slice(:provider,:uid)).first_or_initialize.tap do |user|
        user.name = auth.info.name
        user.username = auth.info.nickname
        user.email = auth.info.email
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.save!
      end
    end

    def role(s) 2**ROLES.index(s.to_s) end
  end
end
