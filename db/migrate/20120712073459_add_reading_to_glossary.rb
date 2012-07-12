class AddReadingToGlossary < ActiveRecord::Migration
  def change
    add_column :glossaries, :reading, :string
  end
end
