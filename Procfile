web: env RUBY_YJIT_ENABLE=1 rm /app/tmp/pids/server.pid && bin/rails server -p $PORT
buoy: env RUBY_YJIT_ENABLE=1 bin/buoys_daemon
forecast: env RUBY_YJIT_ENABLE=1 bin/forecasts_daemon
release: env RUBY_YJIT_ENABLE=1 bin/rails db:migrate db:seed database_views:refresh cache:prune
