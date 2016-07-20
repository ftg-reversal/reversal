const gulp = require('gulp');
const postcss = require('gulp-postcss');
const sorting = require('postcss-sorting');
const stylefmt = require('gulp-stylefmt');

gulp.task('stylefmt', function () {
    return gulp.src('./frontend/css/**/*.css')
        .pipe(postcss([sorting({'sort-order': 'zen'})]))
        .pipe(stylefmt())
        .pipe(gulp.dest('./frontend/css')
    );
});
