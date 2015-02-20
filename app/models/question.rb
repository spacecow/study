class Question < ActiveRecord::Base
  attr_accessible :string, :correct

  has_one :answer

  def mask
    correct ? "*" * correct.length : ""
  end
end
