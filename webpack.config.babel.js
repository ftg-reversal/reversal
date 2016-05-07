'use strict';

const path = require('path');
const webpack = require('webpack');
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const bourbon = require('bourbon').includePaths;

const production = process.env.TARGET === 'production';
const localIdentName = production ? '[local]__[hash:base64:5]' : '[path]___[name]__[local]___[hash:base64:3]'
const devtool = production ? '' : 'inline-source-map'

const defaultPlugins = [
  new webpack.ProvidePlugin({
    jQuery: 'jquery',
    $: 'jquery',
    jquery: 'jquery',
    Tether: 'tether',
    "window.Tether": 'tether'
  }),
  new ExtractTextPlugin(path.join('stylesheets', 'webpack', '[name].css'))
];

const productionPlugins = [
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
];

const plugins = production ? defaultPlugins.concat(productionPlugins) : defaultPlugins;

// css modules
const cssLoader = production ? ExtractTextPlugin.extract('style', 'css?modules!postcss') : 'style!css?modules!postcss'
// global css
const sassLoader = production ? ExtractTextPlugin.extract('style', 'css!postcss!sass?sourceMap!import-glob') : 'style!css!postcss!sass?sourceMap!import-glob'

export default {
  entry: {
    bundle: './frontend/js/index.js',
    // components: './frontend/js/components.js',
    style: './frontend/css/index.sass',

    vendor: ['turbolinks', 'tether', 'tether-drop', 'vue'],
  },

  output: {
    path: path.join(__dirname, 'app', 'assets'),
    filename: path.join('javascripts', 'webpack', '[name].js')
  },

  module: {
    preloaders: [
      { test: /\.css/, loader: 'stylelint' },
      { test: /\.sass/, loader: 'import-glob' }
    ],

    loaders: [
      { test: /.jsx?$/, loader: 'babel-loader', exclude: /node_modules/ },
      { test: /\.jade$/, loader: 'jade' },
      { test: /\.css$/, loader: cssLoader },
      { test: /\.(sass|scss)$/, loader: sassLoader },
      { test: /\.jpg$/, loader: 'url' },
      { test: /\.png$/, loader: 'url' },
      { test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: 'url' },
      { test: /\.(otf|ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: 'url' },
      { test: require.resolve('turbolinks'), loader: 'imports?this=>window' }
    ]
  },

  resolve: {
    extensions: ['', '.js', '.css', '.sass', '.scss'],
    root: [
      path.resolve('./frontend/js'),
      path.resolve('./frontend/css')
    ]
  },

  cssLoader: {
    localIdentName: localIdentName
  },

  sassLoader: {
    indentedSyntax: 'sass',
    includePaths: [bourbon]
  },

  postcss: [
    require('autoprefixer')(),
    require('postcss-import')(),
    require('postcss-simple-vars')(),
    require('postcss-nested')(),
    require('postcss-assets')({ loadPaths: ['frontend/css', 'frontend/js', 'frontend/img', 'frontend/fonts'] }),
    require('postcss-mixins')(),
    require('postcss-extend')(),
    require('postcss-calc')(),
    require('postcss-short')(),
    require('csswring')()
  ],

  plugins: plugins,
  devtool: devtool
};
