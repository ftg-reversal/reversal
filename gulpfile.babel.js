const gulp = require('gulp')
const postcss = require('gulp-postcss');
const sorting = require('postcss-sorting');

gulp.task('sort-css', function () {
    return gulp.src('./frontend/css/**/*.css').pipe(
        postcss([
            sorting({'sort-order': 'zen'})
        ])
    ).pipe(
        gulp.dest('./frontend/css')
    );
});
