/* eslint-disable import/no-commonjs */
/* eslint-disable import/no-nodejs-modules */

const {resolve} = require("path");
const {HashedModuleIdsPlugin} = require("webpack");
const {HotModuleReplacementPlugin} = require("webpack");
const {EnvironmentPlugin} = require("webpack");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const {BundleAnalyzerPlugin} = require("webpack-bundle-analyzer");
const {Plugin: WebpackCommonShake} = require("webpack-common-shake");
const {CleanWebpackPlugin} = require("clean-webpack-plugin");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const WebpackAssetsManifest = require("webpack-assets-manifest");
const DotenvWebpack = require("dotenv-webpack");
const {config: dotenvConfiguration} = require("dotenv");

dotenvConfiguration();

const PACKAGE_ASSETS = [];
const inputDirectory = [__dirname, "..", "..", "browser-client"];
const outputDirectory = [__dirname, "..", "..", "tmp", "browser"];

module.exports = {
  mode: "development",
  devtool: "inline-source-map",
  module: {
    rules: [
      {
        test: /index\.js$/u,
        exclude: /node_modules/u,
        use: {
          loader: "babel-loader",
        },
      },
      {
        test: /\.gql$/u,
        exclude: /node_modules/u,
        loader: "graphql-tag/loader",
      },
    ],
  },
  entry: [
    resolve(...inputDirectory, "index.js"),
  ],
  target: "web",
  output: {
    path: resolve(...outputDirectory),
    filename: "[name].[hash].js",
    chunkFilename: "[id].[chunkhash].js",
  },
  optimization: {
    minimize: false,
    runtimeChunk: "single",
    splitChunks: {
      minSize: 0,
      maxAsyncRequests: Infinity,
      maxInitialRequests: Infinity,
      cacheGroups: {
        internal: {
          test: /@internal[\\/]/u,
          chunks: "initial",
          priority: -40,
        },
        unction: {
          test: /[\\/]node_modules[\\/]@unction/u,
          chunks: "initial",
          priority: -30,
        },
        ramda: {
          test: /[\\/]node_modules[\\/]ramda/u,
          chunks: "initial",
          priority: -30,
        },
        moment: {
          test: /[\\/]node_modules[\\/]moment/u,
          chunks: "initial",
          priority: -20,
        },
        most: {
          test: /[\\/]node_modules[\\/]most/u,
          chunks: "initial",
          priority: -20,
        },
        elliptic: {
          test: /[\\/]node_modules[\\/]elliptic/u,
          chunks: "initial",
          priority: -20,
        },
        bn: {
          test: /[\\/]node_modules[\\/]bn/u,
          chunks: "initial",
          priority: -20,
        },
        redux: {
          test: /[\\/]node_modules[\\/]redux/u,
          chunks: "initial",
          priority: -20,
        },
        react: {
          test: /[\\/]node_modules[\\/]react(?:-dom|-router|-router-dom|-redux)?[\\/]/u,
          chunks: "initial",
          priority: -20,
        },
        babel: {
          test: /[\\/]node_modules[\\/]@babel/u,
          chunks: "initial",
          priority: -20,
        },
        corejs: {
          test: /[\\/]node_modules[\\/]core-js/u,
          chunks: "initial",
          priority: -20,
        },
        pouchdb: {
          test: /[\\/]node_modules[\\/](?:pouchdb|lunr)/u,
          chunks: "initial",
          priority: -20,
        },
        vendors: {
          test: /[\\/]node_modules[\\/]/u,
          chunks: "initial",
          priority: -40,
        },
      },
    },
  },
  devServer: {
    hot: true,
    overlay: true,
    port: 9000,
  },
  plugins: [
    new CleanWebpackPlugin(),
    new DotenvWebpack(),
    new EnvironmentPlugin([
      "NODE_ENV",
      "COUCHDB_USERNAME",
      "COUCHDB_PASSWORD",
      "COUCHDB_URI",
    ]),
    new CopyWebpackPlugin([{
      from: resolve(...inputDirectory, "assets"),
      to: resolve(...outputDirectory, "assets"),
    }]),
    ...PACKAGE_ASSETS.map(([from, ...to]) => new CopyWebpackPlugin([{
      from,
      to: resolve(...outputDirectory, "assets", ...to),
    }])),
    new HotModuleReplacementPlugin(),
    new HashedModuleIdsPlugin(),
    new WebpackAssetsManifest({
      output: "asset-integrity-manifest.json",
      integrity: false,
    }),
    new HtmlWebpackPlugin({
      hash: true,
      template: resolve(...inputDirectory, "templates", "index.html"),
    }),
    new WebpackCommonShake(),
    new BundleAnalyzerPlugin({analyzerMode: "static", openAnalyzer: false}),
  ],
};
