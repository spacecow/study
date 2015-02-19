class CreateAnswers < ActiveRecord::Migration
  def up
    create_table :answers do |t|
      t.integer :quiz_id, null:false
      t.integer :question_id, null:false
      t.string :string
    end
    execute "alter table answers add foreign key (quiz_id) references quizzes (id)"
    execute "alter table answers add foreign key (question_id) references questions (id)"
  end

  def down
    drop_table :answers
  end
end
