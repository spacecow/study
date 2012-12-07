# -*- coding: utf-8 -*-
class RelativeGlossaryPresenter < BasePresenter
  presents :relative

  def actions
    h.content_tag :span, class:'actions' do
      delete_link
    end
  end

  def content
    h.content_tag :span, class:'content' do
      h.link_to relative.secondary_content(@parent), relative.secondary(@parent)
    end
  end

  def kanjis
    h.content_tag :ul, class:'kanjis' do
      h.render partial:'kanjis/kanji', collection:relative.secondary_kanjis(@parent), locals:{taken_glossary:relative.secondary(@parent)}
    end if relative.secondary_kanjis(@parent).present?
  end

  def present
    content +
    (reading.nil? ? "" : "(#{reading})").html_safe
  end

  def reading
    h.content_tag :span, class:'reading' do
      relative.secondary_reading(@parent)
    end unless relative.secondary_reading(@parent).blank?
  end

  def delete_link
    dcase = @object.class.to_s.underscore.downcase
    h.link_to h.t(:delete), h.send("#{dcase}_path",@object,main:@parent), method: :delete, data:{confirm:h.sure?} if h.can? :destroy, @object 
  end
end
