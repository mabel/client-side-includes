var gulp = require('gulp');
var coffee = require('gulp-coffee');
var gutil  = require('gutil');
var uglify = require('gulp-uglify');

gulp.task('lib', function() {
    gulp.src('*.coffee')
        .pipe(coffee({bare: true}).on('error', gutil.log))
        //.pipe(uglify())
        .pipe(gulp.dest('..'))
})

gulp.task('default', ['lib'])
