# README

* Ruby version: 3.0.2

* Framework: Rails 6.1.4.4

* Database: Postgres
* Config database in: config/database.yml

* How to run
  - Requirements: ruby, rails, nodejs, yarn, postgresql.
  - Change config/database.yml host to localhost
  -     bundle install
  -     yarn install
  -     rails db:prepare
  -     rails s

* How to run test
  -     rspec

* Using Docker

  -     docker-compose up -d --build
  -     docker-compose run web rails db:prepare
  -     Test: docker-compose run web rspec
  -     Stop: docker-compose down
