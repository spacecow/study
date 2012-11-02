class SentencePresenter < BasePresenter
  presents :sentence

  def glossaries
    h.content_tag(:ul, class:'glossaries') do
      sentence.glossaries.map{|glossary|
        h.content_tag(:li, class:'glossary') do
          h.render 'sentences/glossary', glossary:glossary
        end
      }.join.html_safe
    end if sentence.glossaries.present?
  end
  #<%= render 'glossaries', glossaries:sentence.glossaries if sentence.glossaries.present? %>
end
