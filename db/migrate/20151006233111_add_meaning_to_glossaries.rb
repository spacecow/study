class AddMeaningToGlossaries < ActiveRecord::Migration
  def change
    add_column :glossaries, :meaning, :string
  end
end
