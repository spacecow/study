class MigrateToDefinition < ActiveRecord::Migration
  def up
    Lookup.all.each do |lookup|
      begin 
        definition = Definition.create glossary_id:lookup.glossary_id, content:lookup.meaning
      rescue ActiveRecord::RecordNotUnique
        definition = Definition.where(content:lookup.meaning).first
      end
      lookup.definition_id = definition.id
      lookup.save
    end
  end

  def down
    Lookup.all.each do |lookup|
      lookup.definition_id = nil
      lookup.save
    end
    Definition.delete_all
  end
end
