class CreateDefinitions < ActiveRecord::Migration

  def up
    create_table :definitions do |t|
      t.string :content
      t.integer :glossary_id, null:false
      t.timestamps
    end
    add_foreign_key :definitions, :glossaries
    add_index :definitions, [:content, :glossary_id], unique:true
  end

  def down
    drop_table :definitions
  end

end
