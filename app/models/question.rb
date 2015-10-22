class Question < ActiveRecord::Base
  attr_accessible :string, :content2, :correct, :reading, :sound

  has_one :answer

  def mask
    correct ? correct.gsub(/\w/,'*') : ""
  end
end
