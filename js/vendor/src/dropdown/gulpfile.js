var gulp   = require('gulp');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');

gulp.task('dd', function(){
    gulp.src(['jquery.dropdown.js'])
        .pipe(rename('dropdown.min.js'))
        .pipe(uglify())
        .pipe(gulp.dest('../..'))
})

gulp.task('default', ['dd'])
