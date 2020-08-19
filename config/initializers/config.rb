# frozen_string_literal: true

require 'yaml'
require 'erb'

# load application settings/configurations
tmpl = File.read(File.join(ROOT_DIR, 'config', 'config.yml'))
conf = ERB.new(tmpl).result
APP_CONFIG = begin
    YAML.safe_load(conf).symbolize_keys.freeze
  rescue StandardError
    {}
  end
