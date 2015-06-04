var gulp = require('gulp');
var jade = require('gulp-jade');
var stylus = require('gulp-stylus');
var coffee = require('gulp-coffee');
var concat = require('gulp-concat');
var rename = require('gulp-rename');
var replace = require('gulp-replace');
var gutil  = require('gutil');

gulp.task('jade', function() {
    var YOUR_LOCALS = {}
    gulp.src('main.jade')
        .pipe(jade({locals: YOUR_LOCALS}))
        .pipe(gulp.dest('..'))
})

gulp.task('jade+coffee', function() {
    var YOUR_LOCALS = {}
    gulp.src(['main.jade', 'main.coffee', 'model.coffee'])
        .pipe(concat('main.tmp', {newLine: ''}))
        .pipe(jade({locals: YOUR_LOCALS}))
        .pipe(gulp.dest('..'))
})

gulp.task('stylus', function() {
    gulp.src('main.styl')
        .pipe(stylus())
        .pipe(gulp.dest('..'))
})

gulp.task('default', ['jade'])
