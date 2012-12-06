class AntonymGlossary < ActiveRecord::Base
  include RelativeGlossary

  belongs_to :glossary
  belongs_to :antonym, :class_name => 'Glossary'

  def secondary(main) main==glossary ? antonym : glossary end
end
