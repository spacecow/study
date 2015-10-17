class SentencePresenter < BasePresenter
  presents :sentence

  def english
    h.content_tag :div, class:'english' do
      h.link_to sentence.english, sentence
    end
  end

  def glossaries
    glossaries = sentence.glossaries
    h.content_tag :ul, class:'glossaries' do
      sentence.lookups.map do |lookup|
        h.render lookup.glossary, sentences:false, kanjis:true, glossary_tag:'li', extra_class:'', meaning:lookup.meaning.nil? ? 'kuk' : lookup.meaning
      end.join.html_safe
    end if glossaries.present?
  end

  def japanese
    h.content_tag :div, class:'japanese' do
      h.link_to sentence.japanese, sentence
    end
  end

  def sentences(sentences)
    h.content_tag :ul, class:'sentences' do
      h.render sentences, glossaries:true
    end if sentences.present?
  end
end
