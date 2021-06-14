# README

* Ruby version: ruby-2.7.2

* Rails version: Rails 6.1.3.2

* Configuration:
```
export MAX_SUBORDINATES=10
export MAX_EMPLOYEES=1000
```
* Dependencies
```
bundle install
```
* Database creation
- database: Postgres
```
rails db:create
rails db:migrate
```

* How to run the test suite
```
rspec spec
```

* Deployment instructions
- We deploy this project via Heroku: `https://doanhung.herokuapp.com/`
- In local
```
rails s
```
