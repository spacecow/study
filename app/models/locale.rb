class Locale < ActiveRecord::Base
  has_many :translations

  attr_accessible :name

  class << self
    def id_from_token(token)
      token.gsub!(/<<<(.+?)>>>/){ create!(name:$1).id}
      token
    end
  end
end
