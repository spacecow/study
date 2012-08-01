class CreateKanjisMeanings < ActiveRecord::Migration
  def change
    create_table :kanjis_meanings do |t|
      t.integer :kanji_id
      t.integer :meaning_id

      t.timestamps
    end
  end
end
