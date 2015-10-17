class LookupPresenter < BasePresenter
  presents :lookup

  def sentence; lookup.sentence end

  def english
    h.content_tag :div, class:'english' do
      h.link_to sentence.english, sentence
    end
  end

  def japanese
    h.content_tag :div, class:'japanese' do
      h.link_to sentence.japanese, sentence
    end
  end

  def meaning
    h.content_tag :div, class:'meaning' do
      h.link_to lookup.meaning.nil? ? "edit me" : lookup.meaning, h.edit_lookup_path(lookup)
    end
  end


end
