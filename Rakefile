require 'fileutils'

desc 'Initialize a shower room for you'
task :init do
  system 'bundle install'
  system 'git submodule init'
  system 'git submodule update'
end

desc 'Guard while you are showering'
task :guard do
  system 'bundle exec guard'
end
