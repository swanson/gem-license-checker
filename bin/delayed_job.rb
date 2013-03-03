#!/usr/bin/env ruby
 
# make this mirror your config/environment files
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'dj-sinatra'))
require 'delayed/command'
Delayed::Command.new(ARGV).daemonize