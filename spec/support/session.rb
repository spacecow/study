def signin_admin
  user = create_admin
  signin
  user
end

def signin_member
  user = create_member
  signin
  user
end

def signin; visit '/auth/facebook' end
