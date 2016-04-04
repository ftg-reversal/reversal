'use strict';

var path = require('path');
var webpack = require('webpack');
var StatsPlugin = require('stats-webpack-plugin');
var BowerWebpackPlugin = require('bower-webpack-plugin');
var autoprefixer = require('autoprefixer');
var precss = require('precss');
var ModernizrWebpackPlugin = require('modernizr-webpack-plugin');

var devServerPort = 3808;

var production = process.env.TARGET === 'production';

var config = {
  entry: {
    'bundle': './webpack/js/index.js',
    'style': './webpack/css/index.sass'
  },

  output: {
    path: path.join(__dirname, '..', 'public', 'webpack'),
    publicPath: '/webpack/',

    filename: production ? '[name]-[chunkhash].js' : '[name].js'
  },

  module: {
    preloaders: [
      {
        test: /\.sass/,
        loader: 'import-glob-loader'
      }
    ],

    loaders: [
      { test: /\.js$/, exclude: /node_modules/, loader: 'babel' },
      { test: /\.jade$/, loader: 'jade' },

      { test: /\.css$/, loader: 'style!css?sourceMap!postcss' },
      {
        test: /\.(sass|scss)$/, loader: 'style!css?sourceMap!postcss!sass?indentedSyntax=sass&sourceMap' +
        '&includePaths[]=' + encodeURIComponent(require('node-bourbon').includePaths) +
        '!import-glob'
      },

      { test: /\.jpg$/, loader: "url?mimetype=image/jpg" },
      { test: /\.png$/, loader: "url?mimetype=image/png" },

      { test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "url-loader?limit=10000&mimetype=application/font-woff" },
      { test: /\.(otf|ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "file-loader" }
    ]
  },
  postcss: function () {
    return [autoprefixer, precss];
  },

  resolve: {
    root: [
      path.join(__dirname, '..', 'webpack'),
      path.join(__dirname, '..', 'webpack', 'js', 'uikit')
    ]
  },

  plugins: [
    // must match config.webpack.manifest_filename
    new StatsPlugin('manifest.json', {
      // We only need assetsByChunkName
      chunkModules: false,
      source: false,
      chunks: false,
      modules: false,
      assets: true
    }),
    new webpack.ProvidePlugin({
      $:               'jquery',
      jQuery:          'jquery',
      jquery:          'jquery',
      'window.jQuery': 'jquery',
      _:               'lodash'
    }),
    new BowerWebpackPlugin(),
    new ModernizrWebpackPlugin()
  ]
};

if (production) {
  config.plugins.push(
    new webpack.NoErrorsPlugin(),
    new webpack.optimize.UglifyJsPlugin({
      compressor: { warnings: false },
      sourceMap: false
    }),
    new webpack.DefinePlugin({
      'process.env': { NODE_ENV: JSON.stringify('production') }
    }),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.OccurenceOrderPlugin()
  );
} else {
  config.devServer = {
    port: devServerPort,
    headers: { 'Access-Control-Allow-Origin': '*' }
  };
  config.output.publicPath = '//localhost:' + devServerPort + '/webpack/';
  // Source maps
  config.devtool = 'inline-source-map';
}

module.exports = config;
