# frozen_string_literal: true
# encoding: utf-8

# Add current path and lib to the load path
$LOAD_PATH << File.expand_path(__dir__)
$LOAD_PATH << File.expand_path('lib', __dir__)

Dir.glob('lib/tasks/*.rake').each { |r| import r }

task default: ['default:all']
