module Kuk
  
  def question_params
    meaning = english
    content = japanese
    if meaning.present?
      [{ string:meaning,
        correct:content }]
    else
      lookups.map do |lookup|
        definition = lookup.definition
        glossary = definition.glossary
        { string:Masker.mask(content,glossary.all_forms),
          content2:glossary.meaning(definition.content),
          correct:glossary.content,
          reading:glossary.reading,
          sound:glossary.sound_url }
      end
    end
  end

end
