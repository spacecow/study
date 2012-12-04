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

  def random_glossary(taken_glossary=nil)
    link = kanji.random_glossary_link(taken_glossary)
    h.content_tag(:span, class:%w(glossary random).join(' ')) do
      " - #{h.link_to *link}".html_safe
    end unless link.nil? 
  end

  def similars
    h.content_tag(:span, class:'similars') do
      ("("+
      kanji.similars.map{|e|
        h.content_tag(:span, class:%w(similar kanji).join(' ')) do
          h.link_to *e.link
        end
      }.join(' ')+
      ")").html_safe
    end if kanji.similars.present?
  end
end
