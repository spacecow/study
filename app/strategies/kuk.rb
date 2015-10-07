module Kuk
  
  def question_params
    meaning = english
    content = japanese
    if meaning.present?
      [{ string:meaning,
        correct:content }]
    else
      []
    end
  end

end
