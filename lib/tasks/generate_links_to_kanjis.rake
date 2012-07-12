task :generate_links_to_kanjis => :environment do
  Glossary.links_to_kanjis
end
