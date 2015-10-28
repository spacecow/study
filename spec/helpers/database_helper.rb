database = YAML.load_file('./config/database.yml')['test']
ActiveRecord::Base.establish_connection database
