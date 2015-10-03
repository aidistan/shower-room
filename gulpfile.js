var gulp   = require('gulp');
var coffee = require('gulp-coffee');
var rename = require('gulp-rename');
var rimraf = require('gulp-rimraf');
var haml   = require('gulp-ruby-haml');
var sass   = require('gulp-sass');
var uglify = require('gulp-uglify');
var gutil  = require('gulp-util');
var merge  = require('merge-stream');

/*
  Utility functions
*/

gulp.dst = function(path) { return gulp.dest('_site/' + (path || '')); };

/*
  Main tasks
*/

gulp.task('default', ['clean', 'haml', 'coffee', 'sass', 'assets', 'vendor']);

/*
  Atom tasks
*/

gulp.task('clean', function() {
  return gulp.src('_site', { read: false })
    .pipe(rimraf());
});

gulp.task('haml', ['clean'], function() {
  return gulp.src('*.haml')
    .pipe(haml())
    .pipe(gulp.dst());
});

gulp.task('coffee', ['clean'], function() {
  return gulp.src('assets/js/*.coffee')
    .pipe(coffee().on('error', gutil.log))
    .pipe(uglify())
    .pipe(gulp.dst('assets/js'));
});

gulp.task('sass', ['clean'], function() {
  return gulp.src('assets/css/*.scss')
    .pipe(sass({ outputStyle: 'compressed' }).on('error', gutil.log))
    .pipe(gulp.dst('assets/css'));
});

gulp.task('assets', ['clean'], function() {
  return gulp.src(['assets/**', '!assets/css/*.scss', '!assets/js/*.coffee'])
    .pipe(gulp.dst('assets/'));
});

gulp.task('vendor', ['clean'], function() {
  return merge(
    gulp.src('vendor/shower/core/shower.min.js')
      .pipe(rename({ dirname: 'js' })),
    gulp.src('vendor/shower/*/styles/screen.css')
      .pipe(rename(function (path) {
        path.basename = 'shower-' + path.dirname.slice(0, -7);
        path.dirname = 'css';
      })),
    gulp.src('vendor/shower/*/fonts/*')
      .pipe(rename({ dirname: 'fonts' }))
  ).pipe(gulp.dst('assets'));
});
