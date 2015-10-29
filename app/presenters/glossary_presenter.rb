# -*- coding: utf-8 -*-

class GlossaryPresenter < BasePresenter
  presents :glossary

  def actions
    h.content_tag :span, class:'actions' do
      h.link_to h.t(:edit), h.edit_glossary_path(glossary) if h.can? :edit, glossary
    end
  end

  def form
    h.content_tag :div, class:%w(form glossary).join(' ') do
      h.render 'glossaries/form', glossary:glossary
    end
  end

  def glossaries lookups
    h.content_tag :ul, class:'glossaries' do
      lookups.map do |lookup|
        h.render lookup.definition.glossary, sentences:true, kanjis:true, extra_class:'', glossary_tag:'li', meaning:nil, lookup:nil
      end.join.html_safe
    end if lookups.present?
  end

  def kanjis(taken_glossary=nil, tag=:div)
    kanjis = glossary.kanjis
    if tag == :div
      h.content_tag(:div, class:'kanjis') do
        (h.subminititle(h.pl :kanji) +
        kanji_list(kanjis,taken_glossary)) if kanjis.present?
      end
    elsif tag == :ul
      kanji_list(kanjis,taken_glossary)
    end 
  end

  def kanji_list(kanjis, taken_glossary=nil)
    h.content_tag(:ul, class:'kanjis') do
      h.render kanjis, taken_glossary:taken_glossary, extra_class:'' if kanjis.present?
    end
  end

  def content
    h.content_tag :span, class:'content' do
      h.link_to glossary.content, glossary
    end
  end

  def reading
    reading = glossary.reading
    (h.content_tag :span, class:'reading' do
      reading 
    end unless reading.nil?).to_s
  end

  def parenthesis
    a = [reading].reject(&:blank?)
    h.content_tag :span, class:'parenthesis' do
      "(#{a.join('; ')})".html_safe
    end
  end

  def meaning lookup 
    h.content_tag :div, class:'meaning' do
      h.link_to lookup.definition.content.nil? ? 'edit me' : lookup.definition.content, h.edit_lookup_path(lookup)
    end
  end

  def sentences
    lookups = glossary.definitions.map(&:lookups).flatten
    h.content_tag :ul, class:'sentences' do
      h.render lookups, glossaries:false, meaning:true if lookups.present?
    end
  end

  # ====== ASSOCIATION LINKS =================
  LINKS = %w(synonym similar antonym)
  LINKS.each do |link|
    define_method("#{link}_links") do
      (glossaries = glossary.send("#{link.pluralize}_total")
      h.content_tag :span, class:[link.pluralize, 'glossaries'].join(' ') do
        glossaries.map{|e|
          h.link_to(e.content, e)
        }.join(' ').html_safe
      end if glossaries.present?).to_s
    end

    define_method link.pluralize do
      glossaries = glossary.send("#{link}_glossaries_total")
      h.content_tag :div, class:[link.pluralize, 'glossaries'].join(' ') do
        (h.subminititle(h.pl(link)) +
        h.content_tag(:ul, class:[link.pluralize, 'glossaries'].join(' ')) do
          h.render glossaries, main:glossary #, glossary_tag:'li', extra_class:link, sentences:false, kanjis:true #main:glossary
        end +
        clear_div) if glossaries.present?
      end
    end
  end
  # ==========================================
end
