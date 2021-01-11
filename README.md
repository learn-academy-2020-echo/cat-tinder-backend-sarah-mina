# Cat Tinder

- $ rails routes - will show all the routes associated with a resource


### Card: Backend Structure
- $ rails new cat-tinder-backend -d postgresql -T
- $ rails db:create
- $ bundle add rspec-rails
- $ rails generate rspec:install
- $ rails generate resource Cat name:string age:integer enjoys:text


### Card: Cat Seeds
- Added array of cat objects to the seeds file
- $ rails db:seed
