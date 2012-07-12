class CreateGlossaryKanjis < ActiveRecord::Migration
  def change
    create_table :glossaries_kanjis do |t|
      t.integer :kanji_id
      t.integer :glossary_id

      t.timestamps
    end
  end
end
