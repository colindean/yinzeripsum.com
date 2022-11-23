# frozen_string_literal: true

desc 'Start the application'
task :start do
  system 'bundle exec shotgun config.ru'
end
