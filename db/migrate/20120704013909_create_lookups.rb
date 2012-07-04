class CreateLookups < ActiveRecord::Migration
  def change
    create_table :lookups do |t|
      t.integer :glossary_id
      t.integer :sentence_id

      t.timestamps
    end
  end
end
