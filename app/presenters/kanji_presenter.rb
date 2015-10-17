# -*- coding: utf-8 -*-
class KanjiPresenter < BasePresenter
  presents :kanji

  def comma_separated_meanings
    kanji.meanings.map(&:name).join(', ')
  end

  def glossaries
    lookup = Struct.new(:meaning).new("?")
    glossaries = kanji.glossaries
    h.content_tag :div, class:'glossaries' do
      (h.subminititle( h.pl :glossary ) +
      h.content_tag(:ul, class:'glossaries') do
        h.render glossaries, extra_class:'', glossary_tag:'li', sentences:false, kanjis:false, lookup:lookup
      end) if glossaries.present?
    end
  end

  # Template -------------------
  def character
    h.content_tag :span, class:'character' do
      h.link_to kanji.character, kanji
    end
  end
  def meanings(tag=:div)
    h.content_tag(tag, class:'meanings') do
      kanji.meanings.map{|e| h.link_to e.name,e}.join(', ').html_safe
    end
  end
  def present
    character + " - " + meanings
  end
  def present_full
    character + " - " + meanings + " - " + random_glossary
  end
  # ----------------------------

  def random_glossary(taken_glossary=nil)
    lookup = Struct.new(:meaning).new("?")
    glossary = kanji.random_glossary(taken_glossary)
    (" - " + h.render(glossary, extra_class:'random', glossary_tag:'span', sentences:false, kanjis:false, lookup:lookup)).html_safe unless glossary.nil?
  end

  def similars(tag=:div)
    if tag == :div
      similarities = kanji.similarities_total
      h.content_tag :div, class:%w(similars kanjis).join(' ') do
        (h.subminititle( h.pl :similar ) +
        h.content_tag(:ul, class:%w(similars kanjis).join(' ')) do
          h.render similarities, main:kanji 
        end) if similarities.present?
      end
    elsif tag == :span
      similars = kanji.similars_total
      h.content_tag(:span, class:%w(similars kanjis).join(' ')) do
        ("("+
        similars.map{|e|
          h.content_tag(:span, class:%w(similar kanji).join(' ')) do
            h.link_to(e.symbol,e)
          end
        }.join(' ')+
        ")").html_safe if similars.present?
      end # :div/:span
    end # kanji.similars.present?
  end # .similars
end
