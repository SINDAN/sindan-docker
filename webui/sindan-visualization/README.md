# SINDAN Visualization

## Features
* List of sindan log
* Simple Dashboard

## Requirements
* Ruby 2.4.1
* MySQL

## Getting Started
* Clone from git
    * git clone this repository

* Configure database.yml

    ```
    cp config/database.yml.example config/database.yml
    ```

* Installation

    ```
    bundle install
    bundle exec rails db:migrate
    bundle exec rails db:seed
    ```

* Testing

    ```
    bundle exec rails spec
    ```
