module Kuk
  
  def question_params
    meaning = english
    content = japanese
    if meaning.present?
      [{ string:meaning,
        correct:content }]
    else
      glossaries.map do |glossary|
        { string:Masker.mask(content,glossary.content),
          content2:glossary.meaning,
          correct:glossary.content,
          reading:glossary.reading }
      end
    end
  end

end
