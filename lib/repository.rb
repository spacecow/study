class Repository
# Parameters: {"utf8"=>"✓", "sentence"=>{"japanese"=>"kouzui ga sono mura wo nomikonde shimatta", "english"=>"The flood overwhelmed the village", "glossary_tokens"=>"<<<魔法>>>", "project_id"=>"4429"}, "commit"=>"Create Sentence"}

  def definition id
    Definition.find id
  end

  def update_definition definition, params
    definition.update_attributes params
  end

  def create_sentence user:, params:
    user.sentences.create! params
  end

  def update_sentence sentence:, params:
    sentence.update_attributes params
    sentence
  end

end
