class AssertionFailure < StandardError
end

class Object
  def assert_equal(s1, s2, message='assertion failure')
    if $AVLUSA
      raise AssertionFailure.new(message) if s1!=s2 
    end
  end
end
