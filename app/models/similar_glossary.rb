class SimilarGlossary < ActiveRecord::Base
  include RelativeGlossary

  belongs_to :glossary
  belongs_to :similar, :class_name => 'Glossary'

  def secondary(main) main==glossary ? similar : glossary end
end
