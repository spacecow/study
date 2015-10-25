class RemoveMeaningFromGlossaries < ActiveRecord::Migration
  def up
    remove_column :glossaries, :meaning
  end

  def down
    add_column :glossaries, :meaning, :string
  end
end
