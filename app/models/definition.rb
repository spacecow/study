class Definition < ActiveRecord::Base
  belongs_to :glossary

  has_many :lookups
  has_many :sentences, :through => :lookups

  attr_accessible :glossary_id, :content

  def self.ids_from_tokens tokens
    tokens.gsub!(/<<<(.+?)>>>/) do
      g, d = $1.split(' - ')
      if glossary = Glossary.where(content:g).first
        glossary
      else
        glossary = Glossary.create!(content:g)
      end
      create!(glossary_id:glossary.id, content:d).id
    end
    tokens.split(",")
  end

  def self.prepoulate arr
    arr.select("definitions.id, concat(glossaries.content, ' - ', definitions.content) as content").
    joins(:glossary)
  end

  def self.tokens query
    #select("definitions.id, concat(glossaries.content, ' - ', definitions.content) as content").
    prepoulate(Definition).
    having("content like ?", "%#{query}%") +
    #joins(:glossary) +
    [{id: "<<<#{query}>>>", content: "New: \"#{query}\""}]
  end

end
