class SentencePresenter < BasePresenter
  presents :sentence

  def glossaries
    h.content_tag :div, class:'glossaries' do
      h.content_tag :ul, class:'glossaries' do
        h.render partial:'sentences/glossary', collection:sentence.glossaries
      end 
    end if sentence.glossaries.present?
  end
end
