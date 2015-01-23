# Haml
guard :haml do
  watch(/^.+(\.html\.haml)$/)
end

# Sass
guard :sass, input: 'assets/css'

# CoffeeScript
coffeescript_options = {
  input: 'assets/js',
  output: 'assets/js',
  patterns: [%r{^assets/js/(.+\.js\.coffee)$}]
}

guard 'coffeescript', coffeescript_options do
  coffeescript_options[:patterns].each { |pattern| watch(pattern) }
end
