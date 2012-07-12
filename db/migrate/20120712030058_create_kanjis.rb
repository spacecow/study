class CreateKanjis < ActiveRecord::Migration
  def change
    create_table :kanjis do |t|
      t.string :symbol

      t.timestamps
    end
  end
end
