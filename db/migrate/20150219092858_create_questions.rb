class CreateQuestions < ActiveRecord::Migration
  def up
    create_table :questions do |t|
      t.integer :quiz_id, null:false
      t.string :string
      t.string :correct
    end
    execute "alter table questions add foreign key (quiz_id) references quizzes (id)"
  end

  def down
    drop_table :questions
  end
end
