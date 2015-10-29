class AddDefinitionIdToLookups < ActiveRecord::Migration
  def change
    add_column :lookups, :definition_id, :integer
  end
end
