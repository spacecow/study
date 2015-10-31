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
      h.link_to lookup.definition.content.nil? ? "no definition" : lookup.definition.content, h.edit_definition_path(lookup.definition)
    end
  end

  def associations
    a = [synonym_links, antonym_links, similar_links].reject(&:blank?)
    h.content_tag :div, class:'associations' do
      a.empty? ? "" : "(#{a.join('; ')})".html_safe
    end
  end

  private

    # ====== ASSOCIATION LINKS =================
    LINKS = %w(synonym antonym similar)
    LINKS.each do |link|
      define_method("#{link}_links") do
        (glossaries = lookup.definition.glossary.send("#{link.pluralize}_total")
        h.content_tag :span, class:[link.pluralize, 'glossaries'].join(' ') do
          glossaries.map{|e|
            h.link_to(e.content, e)
          }.join(' ').html_safe
        end if glossaries.present?).to_s
      end
    end


end
