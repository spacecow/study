class AddMeaningToLookups < ActiveRecord::Migration
  def change
    add_column :lookups, :meaning, :string
    Lookup.all.each do |lookup|
      lookup.meaning = lookup.glossary.meaning
      lookup.save
    end
  end
end
