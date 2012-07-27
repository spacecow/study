def signin_member
  member = create_member
  signin
  member
end

def signin; visit '/auth/facebook' end
