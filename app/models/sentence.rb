class Sentence < ActiveRecord::Base
  attr_accessible :english, :glossary_tokens, :japanese
  attr_reader :glossary_tokens

  has_many :lookups
  has_many :glossaries, :through => :lookups

  #belongs_to :owner, :class_name => 'User'
  belongs_to :user

  def glossary_tokens=(tokens)
    self.glossary_ids = Glossary.ids_from_tokens(tokens) 
  end

  def owner; user end

  class << self
    def ids_from_tokens(tokens)
      tokens.gsub!(/<<<(.+?)>>>/){ create!(japanese:$1).id}
      tokens.split(",")
    end
  end
end
