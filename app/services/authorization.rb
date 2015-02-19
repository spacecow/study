class Authorization
  ADMIN     = 'admin'
  GOD       = 'god'
  MEMBER    = 'member'
  MINIADMIN = 'miniadmin'
  VIP       = 'vip'
  ROLES     = [GOD,ADMIN,MINIADMIN,VIP,MEMBER]


  class << self
    def role(s) 2**ROLES.index(s.to_s) end
    def role?(user,s) roles(user).include?(s.to_s) end
    def roles(user); ROLES.reject{|r| ((user.roles_mask||0) & 2**ROLES.index(r)).zero? } end
  end
end
