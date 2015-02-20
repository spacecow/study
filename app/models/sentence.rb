class Sentence < ActiveRecord::Base
  include Kuk

  belongs_to :project

  has_many :lookups
  has_many :glossaries, :through => :lookups

  #belongs_to :owner, :class_name => 'User'
  belongs_to :user

  attr_accessible :english, :glossary_tokens, :japanese, :project_id
  attr_reader :glossary_tokens

  validates :project_id, presence:true

  def glossary_tokens=(tokens)
    self.glossary_ids = Glossary.ids_from_tokens(tokens) 
  end

  def owner; user end

  def project_name; project.name end

  class << self
    def ids_from_tokens(tokens)
      tokens.gsub!(/<<<(.+?)>>>/){ create!(japanese:$1).id}
      tokens.split(",")
    end
  end

end
