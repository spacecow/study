class AddUserIdToSentences < ActiveRecord::Migration
  def change
    add_column :sentences, :user_id, :integer
  end
end
