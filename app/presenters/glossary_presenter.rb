class GlossaryPresenter < BasePresenter
  presents :glossary

  def content
    h.content_tag :span, class:'content' do
      h.link_to(glossary.content, glossary) +
      "("+
      glossary.reading +
      synonym_links +
      similar_links +
      antonym_links +
      ")"
    end 
  end

  def form
    h.content_tag :div, class:%w(form glossary).join(' ') do
      h.render 'glossaries/form', glossary:glossary
    end
  end

  def kanjis(taken_glossary=nil)
    h.content_tag(:ul, class:'kanjis') do
      h.render partial:'sentences/kanji', collection:glossary.kanjis, locals:{taken_glossary:taken_glossary}
    end if glossary.kanjis.present?
  end

  def present
    content
  end

  def sentences
    h.content_tag :ul, class:'sentences' do
      h.render partial:'glossaries/sentence', collection:glossary.sentences
    end if glossary.sentences.present?
  end

  # ====== ASSOCIATION LINKS =================
  LINKS = %w(synonym similar antonym)
  LINKS.each do |link|
    define_method("#{link}_links") do
      h.content_tag :span, class:[link.pluralize, 'glossaries'].join(' ') do
        ("; " +
        glossary.send("#{link.pluralize}_total").map{|e|
          h.link_to(e.content, e)
        }.join(' ')).html_safe
      end if glossary.send("#{link.pluralize}_total").present?
    end

    define_method link.pluralize do
      h.content_tag :div, class:[link.pluralize, 'glossaries'].join(' ') do
        h.subminititle(h.pl(link)) +
        h.content_tag(:ul, class:[link.pluralize, 'glossaries'].join(' ')) do
          h.render glossary.send("#{link}_glossaries_total"), main:glossary
          #glossary.send("#{link.pluralize}_total").map{|e|
          #  h.content_tag(:li, class:[link, 'glossary'].join(' ')) do
          #    h.link_to(e.content, e)
          #  end
          #}.join.html_safe
        end +
        clear_div
      end if glossary.send("#{link}_glossaries_total?")
    end
  end
  # ==========================================
end
