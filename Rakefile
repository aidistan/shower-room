require 'bundler/setup'

desc 'Initialize a shower room for you'
task :init do
  system 'bundle install'
  system 'git submodule init'
  system 'git submodule update'
end

desc 'Generate a new slide'
task :new do
  if name = ARGV[1]
    system "touch assets/css/#{name}.css.scss"
    system "touch assets/js/#{name}.js.coffee"
    haml = <<-END_OF_DOC
!!!5
%html{lang: 'en'}
  %head
    %title Shower Presentation Engine
    %meta{charset: 'utf-8'}
    %meta{name: 'viewport', content: 'width=792, user-scalable=no'}
    %meta{'http-equiv' => 'x-ua-compatible', content: 'ie=edge'}
    %link{rel: 'stylesheet', href: 'vendor/shower-themes/ribbon/styles/screen.css'}
    %link{rel: 'stylesheet', href: 'assets/css/#{name}.css'}

  %body.list
    %header.caption
      %h1 Shower Presentation Engine
      %p Yours Truly, Famous Inc.

    %section#Cover.slide.cover
      %div
        %h2 Title
        %p Add content here...

    %p.badge
      %a{href: 'https://github.com/shower/shower'} Fork me on Github

    /
      To hide progress bar from entire presentation
      just remove “progress” element.
    .progress
      %div

    %script{src: 'vendor/shower-core/shower.min.js'}
    %script{src: 'assets/js/#{name}.js'}
    END_OF_DOC
    File.open("#{name}.html.haml", 'w').puts haml
  else
    puts "Usage: rake new slide_name"
  end
  exit
end

desc 'Guard while you are showering'
task :guard do
  system 'bundle exec guard'
end
