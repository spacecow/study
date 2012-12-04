class CreateSimilarGlossaries < ActiveRecord::Migration
  def change
    create_table :similar_glossaries do |t|
      t.integer :glossary_id
      t.integer :similar_id

      t.timestamps
    end
  end
end
