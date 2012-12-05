class SynonymGlossary < ActiveRecord::Base
  belongs_to :glossary
  belongs_to :synonym, :class_name => 'Glossary'
end
