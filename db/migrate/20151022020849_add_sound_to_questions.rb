class AddSoundToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :sound, :string
  end
end
