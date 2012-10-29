# -*- coding: utf-8 -*-
class KanjiPresenter < BasePresenter
  presents :kanji

  def comma_separated_meanings
    kanji.meanings.map(&:name).join(', ')
  end

  def similars
    "(#{kanji.similars.join(' ')})" if kanji.similars.present?
  end
end
