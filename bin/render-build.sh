set -o errexit # exit if there is any error
bundle install # to install all gems
bundle exec rake db:migrate # to migrate the db
