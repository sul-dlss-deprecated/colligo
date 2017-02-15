# Colligo #
[![Build Status](https://travis-ci.org/sul-dlss/colligo.svg?branch=master)](https://travis-ci.org/sul-dlss/colligo) | [![Coverage Status](https://coveralls.io/repos/sul-dlss/colligo/badge.svg?branch=master&service=github)](https://coveralls.io/github/sul-dlss/colligo?branch=master)


This is the codebase for the Colligo application, showcasing digital manuscripts.

## Running the server for development
```sh
$ bundle exec rake colligo:server # Spins up Solr, Indexes data, Runs Rails server
```

You can do all of these things manually if you like:

```sh
$ solr_wrapper # start solr
$ bundle exec rake colligo:fixtures # Index fixtures
$ rails s # Start Rails server
```
