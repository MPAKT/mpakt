# frozen_string_literal: true

require 'selenium-webdriver'

Capybara.register_driver :selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless') unless ENV['UI_DEBUG'] == "true"
  options.add_argument("--window-size=1600,1080")
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.configure do |config|
  config.default_max_wait_time = 10 # seconds
  config.default_driver        = :selenium
  config.server_host           = "lvh.me"
end
