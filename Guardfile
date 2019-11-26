guard :rubocop, all_on_start: true, cli: %w[--auto-correct --display-cop-names] do
  watch(/.+\.(rb|rake)$/)
  watch('config/Gemfile')
  watch(%r{(?:.+/)?\.?rubocop(?:_todo)?\.yml$}) { '.' }
end

guard :shell, first_match: true do
  # Restart puma
  watch(%r{config/((.ruby-version|Gemfile.lock)|(application|environment|puma)\.rb|(environments/development.rb|initializers/.+\.rb))}) do |m|
    n "#{m[0]} changed", 'Restarting server...'
    # Copied from https://github.com/rails/rails/blob/master/railties/lib/rails/tasks/restart.rake
    FileUtils.mkdir_p 'tmp'
    FileUtils.touch 'tmp/restart.txt'
    nil
  end

  # Run yarn
  watch('config/package.json') do
    `bin/yarn`
  end

  # Run bundler
  watch('config/Gemfile') do
    ::Bundler.with_clean_env do
      `bin/bundle --without production`
    end
  end
end
