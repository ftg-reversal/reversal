'use strict';

var path = require('path');
var webpack = require('webpack');
var StatsPlugin = require('stats-webpack-plugin');
var BowerWebpackPlugin = require('bower-webpack-plugin');
var autoprefixer = require('autoprefixer');
var precss = require('precss');

var devServerPort = 3808;

var production = process.env.TARGET === 'production';

var config = {
  entry: {
    'index': './webpack/index.js'
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
      { test: /\.css$/, loader: 'style!css?sourceMap!postcss' },
      { test: /\.(sass|scss)$/, loader: 'style!css?sourceMap!postcss!sass?indentedSyntax=sass&sourceMap' +
        '&includePaths[]=' + encodeURIComponent(require('node-bourbon').includePaths) +
        '!import-glob'
      },

      { test: /\.jpg$/, loader: "url?mimetype=image/jpg" },
      { test: /\.png$/, loader: "url?mimetype=image/png" },

      { test: /\.(woff|woff2)$/, loader: 'url?limit=10000&minetype=application/font-woff' },
      { test: /\.ttf$/, loader: 'url?limit=10000&minetype=application/octet-stream' },
      { test: /\.(eot|otf)$/, loader: 'url?limit=10000&minetype=image/svg+xml' },
      { test: /\.svg$/, loader: 'url?limit=10000&minetype=image/svg+xml' }
    ]
  },
  postcss: function () {
    return [autoprefixer, precss];
  },

  resolve: {
    root: [
      path.join(__dirname, '..', 'webpack'),
      path.join(__dirname, '..', 'webpack', 'js', 'uikit'),
      path.join(__dirname, 'bower_components'),
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
      'window.jQuery': 'jquery'
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
  config.devServer = {
    port: devServerPort,
    headers: { 'Access-Control-Allow-Origin': '*' }
  };
  config.output.publicPath = '//localhost:' + devServerPort + '/webpack/';
  // Source maps
  config.devtool = 'eval';
  config.watchOptions = {
    aggregateTimeout: 300,
    poll: 1000
  }
}

module.exports = config;
