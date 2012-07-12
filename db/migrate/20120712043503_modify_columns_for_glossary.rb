class ModifyColumnsForGlossary < ActiveRecord::Migration
  def up
    rename_column :glossaries, :japanese, :content
    remove_column :glossaries, :english
  end

  def down
    rename_column :glossaries, :content, :japanese
    add_column :glossaries, :english, :string
  end
end
