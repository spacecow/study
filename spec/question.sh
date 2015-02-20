while true;
  do RAILS_ENV=test rspec
  spec/features/quizzes/
  spec/features/answers/
  spec/models/answer_spec.rb
  spec/models/question_spec.rb
  spec/controllers/quizzes_controller_spec.rb
  spec/controllers/answers_controller_spec.rb
  spec/views/answers/new.html.erb_spec.rb
  spec/strategies/kuk_spec.rb
  --fail-fast
  --format documentation;
  echo -e \'\\a\';
  for x in 10 9 8 7 6 5 4 3 2 1;
    do printf \"$x \";
    sleep 1;
  done;
  echo \"Running spec again!\";
done
