task :generate_links_to_kanjis => :environment do
  Glossary.link_to_kanjis
end
