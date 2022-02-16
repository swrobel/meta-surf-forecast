web: RUBY_YJIT_ENABLE=1 bin/rails server -p $PORT
buoy: RUBY_YJIT_ENABLE=1 bin/buoys_daemon
forecast: RUBY_YJIT_ENABLE=1 bin/forecasts_daemon
release: RUBY_YJIT_ENABLE=1 bin/rails db:migrate db:seed database_views:refresh cache:prune
