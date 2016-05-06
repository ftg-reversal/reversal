'use strict';

var path = require('path');
var webpack = require('webpack');
var BowerWebpackPlugin = require('bower-webpack-plugin');
var autoprefixer = require('autoprefixer');
var precss = require('precss');

var production = process.env.TARGET === 'production';

var config = {
  entry: {
    'bundle': './frontend/js/index.js',
    'style': './frontend/css/index.sass',

    vendor: ['turbolinks']
  },

  output: {
    path: path.join(__dirname, 'app', 'assets', 'javascripts', 'webpack'),
    filename: '[name].js'
  },

  module: {
    preloaders: [
      { test: /\.sass/, loader: 'import-glob-loader' }
    ],

    loaders: [
      { test: /\.jsx?$/, exclude: /node_modules/, loader: 'babel' },
      { test: /\.jade$/, loader: 'jade' },

      {
        test: /\.(css|sass|scss)$/, loader: "style!css?sourceMap!postcss!sass?indentedSyntax=sass&sourceMap" +
        "&includePaths[]=" + encodeURIComponent(require('node-bourbon').includePaths) +
        "!import-glob"
      },

      { test: /\.jpg$/, loader: "url" },
      { test: /\.png$/, loader: "url" },

      { test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "url" },
      { test: /\.(otf|ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "url" },

      { test: require.resolve('turbolinks'), loader: 'imports?this=>window' }
    ]
  },

  resolve: { root: [ path.resolve('./frontend/js') ] },

  postcss: function () {
    return [autoprefixer, precss];
  },

  plugins: [
    new webpack.ProvidePlugin({
      $:               'jquery',
      jQuery:          'jquery',
      jquery:          'jquery',
      'window.jQuery': 'jquery',
      _:               'lodash'
    }),
    new BowerWebpackPlugin()
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
  // Source maps
  config.devtool = 'inline-source-map';
}

module.exports = config;
