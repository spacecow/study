# -*- coding: utf-8 -*-
class KanjiPresenter < BasePresenter
  presents :kanji

  def comma_separated_meanings
    kanji.meanings.map(&:name).join(', ')
  end

  def glossaries
    h.content_tag :ul, class:'glossaries' do
      h.render partial:'sentences/glossary', collection:kanji.glossaries
    end if kanji.glossaries.present?
  end

  def similars
    "(#{kanji.similars.join(' ')})" if kanji.similars.present?
  end
end
