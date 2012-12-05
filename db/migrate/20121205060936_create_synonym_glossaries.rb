class CreateSynonymGlossaries < ActiveRecord::Migration
  def change
    create_table :synonym_glossaries do |t|
      t.integer :glossary_id
      t.integer :synonym_id

      t.timestamps
    end
  end
end
