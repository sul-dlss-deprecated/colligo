# Colligo #
[![Build Status](https://travis-ci.org/sul-dlss/colligo.svg?branch=master)](https://travis-ci.org/sul-dlss/colligo) | [![Coverage Status](https://coveralls.io/repos/sul-dlss/colligo/badge.svg?branch=master&service=github)](https://coveralls.io/github/sul-dlss/colligo?branch=master)


This is the codebase for the Colligo application, showcasing digital manuscripts.

## Local Development Setup
1. Clone and run `bundle install`
2. Run `bin/rake db:migrate RAILS_ENV=development` or an equivalent to populate the database with development data
3. Run `bundle exec rake` to download and install supplementary service software (Jetty) and run tests
4. Run `bundle exec rake jetty:start`
5. Once the Jetty service has finished spinning up, run `rake colligo:fixtures` to fill in solr fixtures (as distinct for DB migration above)
6. run `rails s` to start the application

## Running Tests during Development
After initial setup, run `bundle exec rake` or equivalent

## Deploying to Stage
