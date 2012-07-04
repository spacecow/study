class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.string :english
      t.string :japanese

      t.timestamps
    end
  end
end
