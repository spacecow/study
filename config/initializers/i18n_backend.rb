DATABASES = {
  "development" => 3,
  "test" => 3,
  "production" => 3
}

TRANSLATION_LOG = Logger.new("log/translation.log")
#$redis = Redis.new(:host => 'localhost', :port => 6379)

if Rails.env.test?
  TRANSLATION_STORE = Redis.new(:db => DATABASES[Rails.env.to_s])
  I18n.backend = I18n::Backend::KeyValue.new(TRANSLATION_STORE)
  #I18n.backend = I18n::Backend::Chain.new(I18n::Backend::KeyValue.new(TRANSLATION_STORE), I18n.backend)
elsif Rails.env.development?
  TRANSLATION_STORE = Redis.new(:db => DATABASES[Rails.env.to_s])
  I18n.backend = I18n::Backend::KeyValue.new(TRANSLATION_STORE)
  #I18n.backend = I18n::Backend::Chain.new(I18n::Backend::KeyValue.new(TRANSLATION_STORE), I18n.backend)
else
  TRANSLATION_STORE = Redis.new(:db => DATABASES[Rails.env.to_s], :host => 'sol10-opt', :port => 6379)
  I18n.backend = I18n::Backend::KeyValue.new(TRANSLATION_STORE)
end
