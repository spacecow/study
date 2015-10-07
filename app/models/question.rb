class Question < ActiveRecord::Base
  attr_accessible :string, :correct, :reading

  has_one :answer

  def mask
    correct ? "*" * correct.length : ""
  end
end
