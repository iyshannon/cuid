#!/usr/bin/env rake
require "bundler/gem_tasks"
require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs << 'lib/cuid'
  t.verbose = true
end
task :default => :test
