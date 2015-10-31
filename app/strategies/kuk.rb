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
        masked = Masker.mask(content,glossary.all_forms)
        { string:masked.first,
          content2:glossary.meaning(definition.content),
          correct:glossary.content,
          reading:"#{glossary.reading}, #{masked.last}",
          sound:glossary.sound_url }
      end
    end
  end

end
