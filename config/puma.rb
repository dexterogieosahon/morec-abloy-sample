# frozen_string_literal: true

require_relative './environment'

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch('RACK_ENV')

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum, this matches the default thread size of Active Record.
#
threads_count = ENV.fetch('PUMA_THREADS') { 8 }.to_i
threads threads_count, threads_count

# Specifies the `port` that Puma will listen on to receive requests, default is 3000.
#
port ENV.fetch('PORT') { 8080 }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
workers ENV.fetch('WEB_CONCURRENCY') { 4 }

rackup DefaultRackup

# In clustered mode, Puma may 'preload' your application.
# This loads all the application code prior to forking.
# Preloading reduces total memory usage of your application via an
# operating system feature called copy-on-write (Ruby 2.0+ only).
# preload_app!

before_fork do
  if defined?(::Sequel)
    Thread.current[:sequel_connect_options] = ::Sequel::DATABASES.map do |db|
      db.disconnect
      db.opts[:uri]
    end
  end
end

# The code in the `on_worker_boot` will be called if you are using
# clustered mode by specifying a number of `workers`. After each worker
# process is booted this block will be run, if you are using `preload_app!`
# option you will want to use this block to reconnect to any threads
# or connections that may have been created at application boot, Ruby
# cannot share connections between processes.
#
on_worker_boot do
  if defined?(::Sequel)
    Thread.current[:sequel_connect_options].each do |db_uri|
      ::Sequel.connect(db_uri)
    end
  end
  OpenTracing.global_tracer =
    Jaeger::Client.build(host: ENV.fetch('JAEGER_HOST', 'localhost'),
                         port: 6831,
                         service_name: 'api')
end
