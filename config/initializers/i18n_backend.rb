#DATABASES = {
#  "development" => 3,
#  "test" => 3,
#  "production" => 3
#}
#
#TRANSLATION_STORE = Redis.new(:db => DATABASES[Rails.env.to_s])
#TRANSLATION_LOG = Logger.new("log/translation.log")
#I18n.backend = I18n::Backend::KeyValue.new(TRANSLATION_STORE)
