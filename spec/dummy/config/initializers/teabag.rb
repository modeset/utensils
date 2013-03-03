Teabag.setup do |config|
  config.root = Utensils::Engine.root
  config.fixture_path = "app/assets/utensils"

  config.suite do |suite|
    suite.javascripts = ["teabag/mocha", "support/expect", "support/sinon"]
  end

end
