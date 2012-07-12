task :generate_kanjis => :environment do
  Kanji.generate_db
end
