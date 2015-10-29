class SentencePresenter < BasePresenter
  presents :sentence

  def english
    h.content_tag :div, class:'english' do
      h.link_to sentence.english, sentence
    end
  end

  def glossaries
    lookups = sentence.lookups
    h.content_tag :ul, class:'glossaries' do
      lookups.map do |lookup|
        h.render lookup.definition.glossary, sentences:false, kanjis:true, glossary_tag:'li', extra_class:'', lookup:lookup
      end.join.html_safe
    end if lookups.present?
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
