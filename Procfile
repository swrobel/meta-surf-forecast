web: env RUBY_YJIT_ENABLE=1 bin/rails server -p $PORT
buoy: env RUBY_YJIT_ENABLE=1 bin/buoys_daemon
forecast: env RUBY_YJIT_ENABLE=1 bin/forecasts_daemon
release: env RUBY_YJIT_ENABLE=1 bin/rails db:migrate:with_data db:seed database_views:refresh cache:prune
