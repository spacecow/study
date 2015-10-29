class Definition < ActiveRecord::Base
  belongs_to :glossary

  attr_accessible :glossary_id, :content

  def self.tokens query
    select("definitions.id, concat(glossaries.content, ' - ', definitions.content) as content").
    having("content like ?", "%#{query}%").
    joins(:glossary) +
    [{id: "<<<#{query}>>>", content: "New: \"#{query}\""}]
  end

end
