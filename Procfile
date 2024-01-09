web: bin/rails server -p $PORT
buoy: bin/buoys_daemon
forecast: bin/forecasts_daemon
release: bin/rails db:migrate:with_data db:seed database_views:refresh cache:prune
