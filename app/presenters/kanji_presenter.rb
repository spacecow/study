# -*- coding: utf-8 -*-
class KanjiPresenter < BasePresenter
  presents :kanji

  def comma_separated_meanings
    kanji.meanings.map(&:name).join(', ')
  end

  def random_glossary(taken_glossary=nil)
    h.content_tag(:span, class:%w(glossary random).join(' ')) do
      " - #{kanji.glossaries.reject{|e| e==taken_glossary}.map(&:content).sample}"
    end if kanji.glossaries.present?
  end

  def similars
    "(#{kanji.similars.join(' ')})" if kanji.similars.present?
  end
end
