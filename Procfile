web: bundle exec rails server -p $PORT
release: bundle exec rails db:migrate db:seed database_views:refresh cache:prune
worker: bin/worker
