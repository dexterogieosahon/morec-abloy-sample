# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

unless %w[production staging].include?(ENV['RACK_ENV'])
  begin
    require 'bundler/audit/task'
    require 'rspec/core/rake_task'
    require 'rubocop/rake_task'
    require 'cucumber/rake/task'

    Bundler::Audit::Task.new
    RSpec::Core::RakeTask.new(:spec)

    RuboCop::RakeTask.new(:rubocop) do |task|
      task.options = ['--display-cop-names']
      task.requires << 'rubocop-rspec'
    end

    Cucumber::Rake::Task.new do |t|
      t.cucumber_opts = %w[--format progress]
    end

    namespace :default do
      task :all do
        # Run rubocop on the current branches commit diff with master:
        # system!("git diff-tree -r --no-commit-id --name-only master@\{u\} head | xargs ls -1 2>/dev/null | grep '\.rb$' | xargs rubocop")
        Rake::Task['rubocop'].invoke
        Rake::Task['bundle:audit'].invoke
        Rake::Task['spec'].invoke
        Rake::Task['cucumber'].invoke
      end
    end
  rescue LoadError
    puts 'Can not load default task.'
  end
end

desc 'list middleware'
task :middleware do
  require 'rack'
  # List middleware classes of rack app
  def middleware_classes(app)
    r = [app]
    while (next_app = r.last.instance_variable_get(:@app))
      r << next_app
    end
    r.map { |e| e.instance_variable_defined?(:@app) ? e.class : e }
  end
  app = Rack::Builder.parse_file(File.expand_path(File.join(__dir__, '..', '..', 'config.ru'))).first
  puts middleware_classes(app)
end
