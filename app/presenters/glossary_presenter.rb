class GlossaryPresenter < BasePresenter
  presents :glossary

  def kanjis(taken_glossary=nil)
    h.content_tag(:ul, class:'kanjis') do
      h.render partial:'sentences/kanji', collection:glossary.kanjis, locals:{taken_glossary:taken_glossary}
    end if glossary.kanjis.present?
  end
end
