const gulp = require('gulp');
const postcss = require('gulp-postcss');
const postcssReporter = require('postcss-reporter');
const sorting = require('postcss-sorting');
const stylefmt = require('gulp-stylefmt');
const stylelint = require('stylelint');

gulp.task('stylefmt', () => (
  gulp.src('./frontend/css/**/*.css')
    .pipe(postcss([sorting({ 'sort-order': 'zen' })]))
    .pipe(stylefmt())
    .pipe(gulp.dest('./frontend/css'))
));

gulp.task('stylelint', () => (
  gulp.src('./frontend/css/**/*.css')
    .pipe(postcss([
      stylelint(),
      postcssReporter({ clearMessages: true }),
    ]))
));
