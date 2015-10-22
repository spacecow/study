class AddSoundToGlossaries < ActiveRecord::Migration
  def change
    add_column :glossaries, :sound, :string
  end
end
