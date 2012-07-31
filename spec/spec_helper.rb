require 'rubygems'
require 'spork'

Spork.prefork do
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    #focus tag
    #---------
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true
  end

  def controller_actions(controller)
    Rails.application.routes.routes.inject({}) do |hash, route|
      if route.requirements[:controller] == controller && !route.verb.nil?
        verb = route.verb.to_s.split(':')[-1][1..-3].downcase
        #route.verb.downcase.empty? ? "get" : route.verb.downcase
        hash[route.requirements[:action]] = verb.empty? ? 'get' : verb
      end
      hash
    end
  end
end

Spork.each_run do
  FactoryGirl.reload
end

RSpec.configure do |config|
  config.before do
    OmniAuth.config.test_mode = true
    pre = {provider:'facebook', uid:"123456", info:{name:'Test Name', nickname:'testuser', email:'test@user.com'}, credentials:{token:'abc123', expires_at:1341979183}}
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(pre)
  end
end
