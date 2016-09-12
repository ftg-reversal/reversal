import gulp from 'gulp';
import eslint from 'gulp-eslint';
import postcss from 'gulp-postcss';
import postcssReporter from 'postcss-reporter';
import sorting from 'postcss-sorting';
import stylefmt from 'gulp-stylefmt';
import stylelint from 'stylelint';

gulp.task('lint', () => (
  gulp.src(['frontend/js/**/*.js', 'frontend/js/**/*.jsx', '!frontend/js/vendor/**'])
    .pipe(eslint())
    .pipe(eslint.format())
    .pipe(eslint.failAfterError())
));

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
