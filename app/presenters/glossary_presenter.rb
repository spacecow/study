class GlossaryPresenter < BasePresenter
  presents :glossary

  def content
    h.content_tag :span, class:'content' do
      h.link_to(glossary.content, glossary) +
      " ("+
      glossary.reading +
      "; " +
      similar_links +
      ")"
    end 
  end

  def form
    h.content_tag :div, class:%w(form glossary).join(' ') do
      h.render 'glossaries/form', glossary:glossary
    end
  end

  private

    def similar_links
      glossary.similars_total.map{|e|
        h.link_to(e.content, e)
      }.join(' ').html_safe
    end
end
