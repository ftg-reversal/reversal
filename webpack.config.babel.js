'use strict';

const path = require('path');
const webpack = require('webpack');
const ExtractTextPlugin = require("extract-text-webpack-plugin");

const production = process.env.TARGET === 'production';
const localIdentName = production ? '[local]__[hash:base64:5]' : '[path]___[name]__[local]___[hash:base64:3]'
const devtool = production ? '' : 'inline-source-map'

const defaultPlugins = [
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
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

const output = production ? {
  path: path.join(__dirname, 'app', 'assets'),
  filename: path.join('javascripts', 'webpack', '[name].js')
} : {
  filename: path.join('[name].js'),
  publicPath: 'http://localhost:3500/'
}

const cssLoader = production ? ExtractTextPlugin.extract('style', 'css!postcss') : 'style!css?sourceMap!postcss'
const sassLoader = production ? ExtractTextPlugin.extract('style', 'css!postcss!sass') : 'style!css?sourceMap!postcss!sass?sourceMap'

export default {
  entry: {
    bundle: './frontend/js/index.js',
    style: './frontend/css/index.js',
    vendor: ['jquery-ujs', 'sweetalert', 'turbolinks', 'tether', 'vue'],
  },

  output: output,

  module: {
    preloaders: [
      { test: /\.css/, loader: 'stylelint' },
    ],

    loaders: [
      { test: /\.html$/, loader: 'html' },
      { test: /\.jsx?$/, loader: 'babel-loader', exclude: /node_modules/ },
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
    indentedSyntax: 'sass'
  },

  postcss: [
    require('autoprefixer')({ browsers: 'last 2 versions' }),
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
  devtool: devtool,
  devServer: {
    headers: {
      "Access-Control-Allow-Origin": "http://localhost:3000",
      "Access-Control-Allow-Credentials": "true"
    }
  }
};
