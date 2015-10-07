class AddReadingToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :reading, :string
  end
end
