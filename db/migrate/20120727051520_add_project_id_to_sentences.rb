class AddProjectIdToSentences < ActiveRecord::Migration
  def change
    add_column :sentences, :project_id, :integer
  end
end
