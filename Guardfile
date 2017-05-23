# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

require_relative 'config/initializers/rubocop'

guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new

  files = ['Gemfile']
  files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end

guard :rubocop, all_on_start: true, cli: RUBOCOP_OPTS do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

guard :shell do
  # Restart server when tmp/restart.txt is changed
  watch(%r{.powrc|.powenv|.rvmrc|.ruby-version|Gemfile*|config/(application|environment|puma)\.rb|config/(environments|initializers)/.*\.rb}) do |m|
    n 'Restarting server...', "#{m[0]} changed", :pending

    # https://github.com/rails/rails/blob/master/railties/lib/rails/tasks/restart.rake
    FileUtils.mkdir_p 'tmp'
    FileUtils.touch 'tmp/restart.txt'
    FileUtils.rm_f 'tmp/pids/server.pid'
    nil
  end
end
