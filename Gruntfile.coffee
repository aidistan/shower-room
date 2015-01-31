module.exports = (grunt) ->

  # Load grunt tasks automatically
  require('load-grunt-tasks')(grunt);

  # Time how long tasks take. Can help when optimizing build times
  require('time-grunt')(grunt);

  grunt.initConfig
    cfg:
      dist: '_site'
    pkg: grunt.file.readJSON('package.json')
    clean:
      dist: ['<%= cfg.dist %>']
    sass:
      dist:
        options:
          sourcemap: 'none'
          style: 'compressed'
        files: [
          expand: true,
          cwd: 'assets/css'
          src: ['*.scss']
          dest: '<%= cfg.dist %>/assets/css'
          ext: '.css'
        ]
    coffee:
      dist:
        files: [
          expand: true,
          cwd: 'assets/js',
          src: ['*.coffee'],
          dest: '<%= cfg.dist %>/assets/js',
          ext: '.js'
        ]
    uglify:
      dist:
        files: [
          expand: true,
          cwd: '<%= cfg.dist %>/assets/js',
          src: '*.js',
          dest: '<%= cfg.dist %>/assets/js'
        ]
    haml:
      dist:
        files: [
          expand: true,
          cwd: '.'
          src: ['*.haml']
          dest: '<%= cfg.dist %>'
          ext: '.html'
        ]
    copy:
      assets:
        files: [
          expand: true
          cwd: 'assets/'
          src: ['**', '!css/*.scss', '!js/*.coffee']
          dest: '<%= cfg.dist %>/assets'
        ]
      shower:
        files: [
           {src: 'vendor/shower/core/shower.min.js', dest: '<%= cfg.dist %>/vendor/shower/core/shower.min.js'},
           {src: 'vendor/shower/ribbon/styles/screen.css', dest: '<%= cfg.dist %>/vendor/shower/ribbon/styles/screen.css'},
           {src: 'vendor/shower/bright/styles/screen.css', dest: '<%= cfg.dist %>/vendor/shower/bright/styles/screen.css'},
           {expand: true, src: ['vendor/shower/bright/fonts/*'], dest: '<%= cfg.dist %>', filter: 'isFile'},
           {expand: true, src: ['vendor/shower/ribbon/fonts/*'], dest: '<%= cfg.dist %>', filter: 'isFile'},
        ]
    watch:
      options: {
        livereload: true,
      },
      css:
        files: ['assets/css/*.scss']
        tasks: ['sass']
      js:
        files: ['assets/js/*.coffee']
        tasks: ['coffee', 'uglify']
      html:
        files: ['*.haml']
        tasks:  ['haml']
      assets:
        files: ['assets/**/*', '!assets/css/*.scss', '!assets/js/*.coffee']
        tasks: ['copy:assets']
      shower:
        files: [
          'vendor/shower/core/shower.min.js'
          'vendor/shower/bright/fonts/*'
          'vendor/shower/bright/styles/screen.css'
          'vendor/shower/ribbon/fonts/*'
          'vendor/shower/ribbon/styles/screen.css]'
        ]
        tasks: ['copy:shower']
    connect:
      server:
        options:
          livereload: true
          port: 4000
          base: '<%= cfg.dist %>'

  grunt.registerTask('build', ['clean', 'copy', 'sass', 'coffee', 'uglify', 'haml']);
  grunt.registerTask('serve', ['build', 'connect', 'watch']);

  grunt.registerTask('default', 'build');
