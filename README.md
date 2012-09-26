firehose-sinatra-chat-example
=============================

firehose/sinatra/datamapper/backbone/redis chat server examplesimple chat server using firehose.io

## PRE-REQS

  * Ruby

  http://www.ruby-lang.org/en/

  I like rvm ( https://rvm.io/ ).

  * bundler gem

    $ gem install bundler

  * Redis

  Ubuntu

      $ sudo apt-get install redis-server

  OSX

      $ brew install redis

  * sqlite3

  Ubuntu

      $ sudo apt-get install libsqlite3-dev

  OSX

      $ brew install sqlite

## DEPENDENCIES

    $ bundle installing

## RUNNING

 First time:
    $ rake db:create

 Every time:
    $ foreman start
