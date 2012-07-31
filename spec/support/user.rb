def create_admin(h={})
  create_user_with_role(:admin,h)
end
def create_member(h={})
  create_user_with_role(:member,h)
end

private

  def create_user_with_role(s,h={})
    create_user_with_hash h.merge({:roles_mask=>User.role(s), provider:'facebook', uid:'123456'})
  end
  def create_user_with_hash(h={})
    FactoryGirl.create(:user,h)
  end
