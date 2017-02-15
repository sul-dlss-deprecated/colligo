# Colligo #
[![Build Status](https://travis-ci.org/sul-dlss/colligo.svg?branch=master)](https://travis-ci.org/sul-dlss/colligo) | [![Coverage Status](https://coveralls.io/repos/sul-dlss/colligo/badge.svg?branch=master&service=github)](https://coveralls.io/github/sul-dlss/colligo?branch=master)


This is the codebase for the Colligo application, showcasing digital manuscripts.

## Local Development Setup
Run `bundle exec rake colligo:install` to install gems, jetty, migrate the DB, and start the Solr server with fixtures.
Run `rails s` to run the application

## Running Tests during Development
After initial setup, run `bundle exec rake` or equivalent

## Deploying to Stage
