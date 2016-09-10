import gulp from 'gulp';
import postcss from 'gulp-postcss';
import postcssReporter from 'postcss-reporter';
import sorting from 'postcss-sorting';
import stylefmt from 'gulp-stylefmt';
import stylelint from 'stylelint';

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
