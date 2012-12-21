# -*- coding: utf-8 -*-

class SimilarityPresenter < BasePresenter
  presents :similarity

  def actions
    h.content_tag :span, class:'actions' do
      h.link_to 'Delete', h.similarity_path(similarity, main_id:@parent.id), method: :delete, data:{confirm:h.sure?} if h.can? :destroy, similarity
    end
  end

  def character
    h.content_tag :span, class:'character' do
      h.link_to similarity.secondary_character(@parent), similarity.secondary(@parent)
    end
  end

  def meanings
    h.content_tag :span, class:'meanings' do
      similarity.secondary_meanings(@parent).map{|e| h.link_to e.name,e}.join(', ').html_safe
    end
  end
end

