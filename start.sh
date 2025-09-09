#!/bin/bash

# Error
set -e

#echo "DROP the DataBase"
rails db:drop

#echo "CREATE the DataBase"
rails db:create

#echo "CREATE the TABLE"
rails db:migrate

#echo "INSERT data in the DataBase"
rails db:seed

#echo "STARTING the coTUTOR"
rails s --port=3000 #& bundle exec sidekiq


