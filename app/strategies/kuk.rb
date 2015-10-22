module Kuk
  
  def question_params
    meaning = english
    content = japanese
    if meaning.present?
      [{ string:meaning,
        correct:content }]
    else
      lookups.map do |lookup|
        glossary = lookup.glossary
        { string:Masker.mask(content,glossary.all_forms),
          content2:lookup.meaning,
          correct:glossary.content,
          reading:glossary.reading,
          sound:glossary.sound_url }
      end
    end
  end

end
