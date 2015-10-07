class AddContent2ToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :content2, :string
  end
end
