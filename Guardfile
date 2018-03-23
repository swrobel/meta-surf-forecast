guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new

  files = ['Gemfile']
  files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end

guard :rubocop, all_on_start: true, cli: ['--auto-correct'] do
  watch(%r{.+\.rb$})
  watch(%r{.+\.rake$})
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
