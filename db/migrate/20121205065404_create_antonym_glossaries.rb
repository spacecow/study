class CreateAntonymGlossaries < ActiveRecord::Migration
  def change
    create_table :antonym_glossaries do |t|
      t.integer :glossary_id
      t.integer :antonym_id

      t.timestamps
    end
  end
end
