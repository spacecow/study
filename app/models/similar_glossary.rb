class SimilarGlossary < ActiveRecord::Base
  belongs_to :glossary
  belongs_to :similar, :class_name => 'Glossary'
end
