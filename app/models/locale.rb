class Locale < ActiveRecord::Base
  has_many :translations

  attr_accessible :name

  class << self
    def id_from_token(token)
      token.gsub!(/<<<(.+?)>>>/){ create!(name:$1).id}
      token
    end

    def tokens(query)
      tokens = where("name like ?", "%#{query}%")
      if tokens.empty?
        [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
      else
        tokens
      end
    end
  end
end
