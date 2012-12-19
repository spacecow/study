# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'Kanji show' do
  let(:dragon){ create :kanji, symbol:'竜' }

  context "similars" do
    let(:devil){ create :kanji, symbol:'鬼' }
    before{ dragon.similars << devil }
    subject{ find 'div.similars' }
      
    context "direct" do
      before{ visit kanji_path(dragon) }
      it{ should have_content '鬼' }
      it{ should_not have_content '竜' }
    end

    context "inverse" do
      before{ visit kanji_path(devil) }
      it{ should_not have_content '鬼' }
      it{ should have_content '竜' }
    end
  end
end
