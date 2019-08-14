ECHO Running windows test script

call rubocop
call rails_best_practices

call bundle exec rails webpacker:compile RAILS_ENV=test
call bundle exec rspec

ECHO All done
