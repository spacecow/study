class SynonymGlossary < ActiveRecord::Base
  include RelativeGlossary
  belongs_to :glossary
  belongs_to :synonym, :class_name => 'Glossary'

  def secondary(main) main==glossary ? synonym : glossary end
end
