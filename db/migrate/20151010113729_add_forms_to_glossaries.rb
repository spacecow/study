class AddFormsToGlossaries < ActiveRecord::Migration
  def change
    add_column :glossaries, :forms, :string
  end
end
