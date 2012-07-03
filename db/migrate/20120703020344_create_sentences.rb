class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.string :english
      t.string :japanese
      t.integer :glossary_id

      t.timestamps
    end
  end
end
