module.exports = function(options) {
  var path = require('path');
  var webpack = require('webpack');
  var config = {};

  config.context = __dirname;

  config.entry = {
    scoreboard: './app/webpack/scoreboard.js',
    default: './app/webpack/default.js'
  };

  config.output = {
    path: path.join(__dirname, "app/assets/javascripts/entries"),
    filename: "[name].js"
  }

  config.plugins = [
    new webpack.ProvidePlugin({
      'fetch': 'imports?this=>global!exports?global.fetch!whatwg-fetch'
    })
  ];

  config.module = {
    loaders: [
      { test: /\.js$/,
        exclude: /node_modules/,
        loader: "babel-loader",
        query: {
          presets: ['es2015-webpack']
        }
      }
    ]
  }

  config.resolve = {
    extensions: ['', '.js'],
    modules: [path.join(__dirname, "app/webpack"), 'node_modules']
  };

  return config;
};
