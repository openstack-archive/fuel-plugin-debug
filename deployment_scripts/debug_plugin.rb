#!/usr/bin/env ruby
require 'rubygems'
require 'hiera'
require 'fileutils'

HIERA_CONFIG  = '/etc/puppet/hiera.yaml'
OVERRIDE_FILE = '/etc/hiera/override/plugins.yaml'
OVERRIDE_FOLDER = '/etc/hiera/override'

def hiera
  return $hiera if $hiera
  $hiera = Hiera.new(:config => HIERA_CONFIG)
  Hiera.logger = "noop"
  $hiera
end

def debug_plugin
  plugin_data = hiera.lookup 'debug_plugin', [], {}, nil, :hash
  raise 'Invalid plugin data!' unless plugin_data.is_a? Hash
  plugin_data
end

def yaml_additional_config
  debug_plugin.fetch 'yaml_additional_config', ''
end

def ensure_override_directory
  FileUtils.mkdir_p OVERRIDE_FOLDER unless File.directory? OVERRIDE_FOLDER
end

def write_override_file(data)
  File.open(OVERRIDE_FILE, 'w') do |f|
    f.puts data
  end
end

ensure_override_directory
write_override_file yaml_additional_config

