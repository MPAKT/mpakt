# Welcome to MPAKT.

## About

MPAKT. is technology to enable a friendly, supportive community. You'll find us live at mpakt.app, 
if we got SSL working.

## Contributing

Please do help us! We welcome contributions. MPAKT. is built using Ruby on Rails and PostgreSQL, 
with HTML templates, SCSS, and a tiny bit of JavaScript.

## Get started

We recommend that you run on a unix machine. It is possible to get some of MPAKT. working on windows,
but the combination of the thredded dependency with webpacker and rails 5 seems to break some of the
thredded functions.

### Set up your environment 

Install or update / downdate:
* Brew
* Rails 5.2
* Ruby 2.5
* Postgres 9.6
* yarn 1.19

Fork the mpakt repository

Run install and setup
```sh
bundle install
yarn install
bundle exec rails db:setup
```

Start the server
```sh
rails s
```

If any of this sounds like it's in a foreign language, send us an email to info@mpakt.net

### Run the tests

We use two static code checkers:
```sh
rubocop
rails_best_practices
```

And we write automated tests in ruby selenium with chromedriver, also see the troubleshooting section below:
```sh
bundle exec rspec
```

A test script is provided which will run all of these together, and calculate coverage
```sh
bin/test
```

By default the spec tests are run against chromedriver in headless mode.
If you want to see a test run live, set this environment variable:

`UI_DEBUG=true`

Reset to false to turn off the live browser

`UI_DEBUG=false`

## Continuous integration

We do not have continuous integration configured, if you would like it, please volunteer!

## Webpacker

MPAKT. uses webpacker, which may need you to install a bunch of stuff with yarn, 
for more information see
https://www.botreetechnologies.com/blog/introducing-jquery-in-rails-6-using-webpacker

## Troubleshooting

1) If you see this error, you need to install chromedriver:

`Selenium::WebDriver::Error::WebDriverError: Unable to find Mozilla geckodriver.`

2) If you see a webpacker error that has an empty manifest file then use `bin/test` or compile the JS before running the test suite with this command:

```sh
$ RAILS_ENV=test bundle exec rails webpacker:compile
```

### Install chrome driver on unix

```
$ brew install chromedriver
```

