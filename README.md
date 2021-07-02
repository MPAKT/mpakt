# Welcome to MPAKT.

## About

MPAKT. is technology to enable a friendly, supportive community. We are a virtual community of people of color, womxn, neuro-diverse, 
and allies using tech as a tool to connect and empower women of color. We provide a network for growth and healing through resources, 
discussion, supportive relationships, and opportunities.

## Contributing

Please do help us! We welcome contributions. MPAKT. is built using Ruby on Rails and PostgreSQL, 
with HTML templates, SCSS, and a tiny bit of JavaScript.

## Get started

We recommend that you run on a unix operating system. Please don't use windows unless you have mastered thredded + webpacker + rails
black arts and are able to do so without support.

### Set up your environment 

Install:
* Brew
* Rails 5.2
* Ruby 2.6
* Postgres 12
* yarn

Fork and clone the mpakt repository, see 
https://help.github.com/en/github/getting-started-with-github/fork-a-repo

Install and setup
```sh
bundle install
yarn install
bundle exec rails db:setup
```

Start the server
```sh
rails s
```

Visit the local server at http://localhost:3000/, and if everything has worked, you will see MPAKT.

The first launch may be a little slow, it should speed up in time.

If any of this sounds like it's in a foreign language, send us an email to info@mpakt.net

### Users

You can create new regular users through the "Join" link. But they won't have admin or moderator 
permissions.

To set the permissions, create a regular user, then update through the rails console as follows:

```sh
rails c

=>User.all.last.update_attributes(volunteer: true, admin: true)
=>quit
```

Sign out, then sign in again, and you should now have admin and moderator permissions

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

Set back to false to turn off the live browser

`UI_DEBUG=false`

## Continuous integration

We do not have continuous integration configured, if you would like it, please volunteer to set it up!

## Webpacker

MPAKT. uses webpacker, which may need you to install a bunch of stuff with yarn, 
for more information see
https://www.botreetechnologies.com/blog/introducing-jquery-in-rails-6-using-webpacker

## Troubleshooting

1) If you see this error, you need to install chromedriver:

`Selenium::WebDriver::Error::WebDriverError: Unable to find Mozilla geckodriver.`

2) If you see a webpacker error that has an empty manifest file then use `bin/test` or compile the JS before running the 
   test suite with this command:

```sh
$ RAILS_ENV=test bundle exec rails webpacker:compile
```

### Install chrome driver on unix

```
$ brew install chromedriver
```

