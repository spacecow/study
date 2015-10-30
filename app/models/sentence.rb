class Sentence < ActiveRecord::Base
  include Kuk

  belongs_to :project

  has_many :lookups
  #has_many :glossaries, :through => :lookups
  has_many :definitions, :through => :lookups

  #belongs_to :owner, :class_name => 'User'
  belongs_to :user

  attr_accessible :english, :definition_tokens, :glossary_tokens, :japanese, :project_id
  attr_reader :glossary_tokens, :definition_tokens

  validates :project_id, presence:true

  def definition_tokens= tokens
    self.definition_ids = Definition.ids_from_tokens tokens 
  end

  def definitions_prepopulate
    Definition.prepoulate definitions
  end

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
