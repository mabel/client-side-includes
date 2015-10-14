var gulp    = require('gulp');
var jade    = require('gulp-jade');

gulp.task('jade', function() {
    var YOUR_LOCALS = {}
    gulp.src('main.jade')
        .pipe(jade({locals: YOUR_LOCALS}))
        .pipe(gulp.dest('..'))
})

gulp.task('default', ['jade'])
