def signin_member
  create_member
  signin
end
def signin; visit '/auth/facebook' end
