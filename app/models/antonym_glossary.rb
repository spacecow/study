class AntonymGlossary < ActiveRecord::Base
  belongs_to :glossary
  belongs_to :antonym, :class_name => 'Glossary'
end
