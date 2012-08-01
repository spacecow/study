class CreateSimilarities < ActiveRecord::Migration
  def change
    create_table :similarities do |t|
      t.integer :kanji_id
      t.integer :similar_id

      t.timestamps
    end
  end
end
