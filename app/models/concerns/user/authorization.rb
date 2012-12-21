class User
  module Authorization
    extend ActiveSupport::Concern

    ADMIN     = 'admin'
    GOD       = 'god'
    MEMBER    = 'member'
    MINIADMIN = 'miniadmin'
    VIP       = 'vip'
    ROLES     = [GOD,ADMIN,MINIADMIN,VIP,MEMBER]

    def role?(s) roles.include?(s.to_s) end
    def roles; ROLES.reject{|r| ((roles_mask||0) & 2**ROLES.index(r)).zero? } end

    module ClassMethods
      def role(s) 2**ROLES.index(s.to_s) end
    end
  end
end
