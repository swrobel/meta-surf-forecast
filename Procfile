web: bin/rails server -p $PORT
buoy: bin/buoys_daemon
forecast: bin/forecasts_daemon
release: bin/rails db:migrate db:seed database_views:refresh cache:prune
