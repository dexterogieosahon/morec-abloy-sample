# frozen_string_literal: true

if %w[development].include?(ENV['RACK_ENV'])
  require 'yard'
  namespace :doc do
    YARD::Rake::YardocTask.new do |task|
      task.files = ['app/**/*.rb']
      task.options = ['--no-private']
    end
  end

  desc 'Generate swagger.json'
  task :swagger do
    require 'config/boot'
    File.open('swagger.json', 'w') do |f|
      f.puts ::Aux.h2json(::OpenApi::ApiDefinitions::Partners::V1::Main.docs)
    end
  end
end
