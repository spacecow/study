class CreateGlossaries < ActiveRecord::Migration
  def change
    create_table :glossaries do |t|
      t.string :english
      t.string :japanese

      t.timestamps
    end
  end
end
