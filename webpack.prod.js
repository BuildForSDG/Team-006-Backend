/* eslint-disable import/no-extraneous-dependencies */
// eslint-disable-next-line no-unused-vars
const webpack = require('webpack');
const path = require('path');
const fs = require('fs');

const nodeModules = {};
fs.readdirSync('node_modules')
  .filter((x) => ['.bin'].indexOf(x) === -1)
  .forEach((mod) => {
    nodeModules[mod] = `commonjs ${mod}`;
  });

module.exports = {
  entry: [
    './src/index.js'
  ],
  target: 'node',
  devtool: 'source-map',
  output: {
    path: path.resolve(__dirname, 'build'),
    filename: 'main.js',
    publicPath: 'build/'
  },
  node: {
    __dirname: false
  },
  mode: 'production',
  externals: nodeModules,
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        }
      }
    ]
  }
};
