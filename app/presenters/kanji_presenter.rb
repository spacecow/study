# -*- coding: utf-8 -*-
class KanjiPresenter < BasePresenter
  presents :kanji

  def comma_separated_meanings
    kanji.meanings.map(&:name).join(', ')
  end

  def random_glossary(taken_glossary=nil)
    r = kanji.random_glossary(taken_glossary)
    h.content_tag(:span, class:%w(glossary random).join(' ')) do
      " - #{h.link_to *r}".html_safe
    end unless r.nil? 
  end

  def similars
    "(#{kanji.similars.join(' ')})" if kanji.similars.present?
  end
end
