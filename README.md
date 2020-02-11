# README

README for the MPAKT. app

## Webpacker

MPAKT. uses webpacker, which may need you to install a bunch of stuff with yarn, for more information see
https://www.botreetechnologies.com/blog/introducing-jquery-in-rails-6-using-webpacker

## Test

### Execute test suite

Setup the test database:

```sh
$ bundle exec rails db:test:prepare
```

Then run the tests:

```sh
$ bundle exec bin\test # windows
(Linux / unix script still todo)
```

By default the spec tests are run against chromedriver in headless mode.
If you want to see a test run live, set this environment variable:

`UI_DEBUG=true`

#### Troubleshooting

1) If you see this error, you need to install chromedriver:

`Selenium::WebDriver::Error::WebDriverError: Unable to find Mozilla geckodriver.`

2) If you see a webpacker error that has an empty manifest file then use `bin/test` or compile the JS before running the test suite with this command:

```sh
$ RAILS_ENV=test bundle exec rails webpacker:compile
```

### Install chrome driver

#### Unix

```
$ brew install chromedriver
```

#### Windows

Download chromedriver from here:
<http://chromedriver.storage.googleapis.com/index.html>

Extract the contents of the zip to your project location, for example C:\fflow\chromedriver.exe

If you see this error:

```
[18992:9784:0619/142315.893:ERROR:install_util.cc(589)] Unable to create registry key HKLM\SOFTWARE\Policies\Google\Chrome for reading result=2
```

Create missing registry keys as documented here:
<https://github.com/SeleniumHQ/selenium/issues/5966>
