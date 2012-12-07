# -*- coding: utf-8 -*-
class KanjiPresenter < BasePresenter
  presents :kanji

  def comma_separated_meanings
    kanji.meanings.map(&:name).join(', ')
  end

  def glossaries
    h.content_tag :ul, class:'glossaries' do
      h.render partial:'kanjis/glossary', collection:kanji.glossaries
    end if kanji.glossaries.present?
  end

  # Template -------------------
  def character
    h.content_tag :span, class:'character' do
      h.link_to kanji.character, kanji
    end
  end
  def meanings(tag=:div)
    h.content_tag tag, class:'meanings' do
      kanji.meanings.map{|e| h.link_to e.name,e}.join(', ').html_safe
    end
  end
  def present
    character + " - " + meanings(:span)
  end
  # ----------------------------

  def random_glossary(taken_glossary=nil)
    link = kanji.random_glossary_link(taken_glossary)
    h.content_tag(:span, class:%w(glossary random).join(' ')) do
      " - #{h.link_to *link}".html_safe
    end unless link.nil? 
  end

  def similars(tag=:div)
    if kanji.similars.present?
      if tag == :div
        h.content_tag :div, class:%w(similars kanjis).join(' ') do
          h.subminititle( h.pl :similar ) +
          h.content_tag(:ul, class:'similars') do
            h.render partial:'kanjis/kanji', collection:kanji.similars, locals:{klass:'similar'}
          end
        end
      elsif tag == :span
        h.content_tag(:span, class:%w(similars kanjis).join(' ')) do
          ("("+
          kanji.similars.map{|e|
            h.content_tag(:span, class:%w(similar kanji).join(' ')) do
              h.link_to *e.link
            end
          }.join(' ')+
          ")").html_safe
        end
      end # :div/:span
    end # kanji.similars.present?
  end # .similars
end
