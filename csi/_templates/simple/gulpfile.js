var gulp    = require('gulp');
var jade    = require('gulp-jade');
var stylus  = require('gulp-stylus');
var coffee  = require('gulp-coffee');
var concat  = require('gulp-concat');

gulp.task('jade', function() {
    var YOUR_LOCALS = {}
    gulp.src('main.jade')
        .pipe(jade({locals: YOUR_LOCALS}))
        .pipe(gulp.dest('..'))
})

gulp.task('coffee', function() {
    gulp.src('*.coffee')
        .pipe(concat('main.tmp', {newLine: ''}))
        .pipe(coffee())
        .pipe(gulp.dest('..'))
})

gulp.task('stylus', function() {
    gulp.src('main.styl')
        .pipe(stylus())
        .pipe(gulp.dest('..'))
})

gulp.task('default', ['jade', 'coffee', 'stylus'])
