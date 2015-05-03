var gulp = require('gulp');
var jade = require('gulp-jade');
var stylus = require('gulp-stylus');
var coffee = require('gulp-coffee');
var gutil  = require('gutil');

gulp.task('jade', function() {
    var YOUR_LOCALS = {}
    gulp.src('main.jade')
        .pipe(jade({locals: YOUR_LOCALS}))
        .pipe(gulp.dest('..'))
})

gulp.task('stylus', function() {
    gulp.src('main.styl')
        .pipe(stylus())
        .pipe(gulp.dest('..'))
})

gulp.task('coffee', function() {
    gulp.src('main.coffee')
        .pipe(coffee({bare: true}).on('error', gutil.log))
        .pipe(gulp.dest('..'))
})

gulp.task('default', ['jade', 'stylus'/*, 'coffee'*/])
