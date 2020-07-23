/* eslint-disable import/no-commonjs */
/* eslint-disable import/no-nodejs-modules */
const {resolve} = require("path");
const webpackNodeExternals = require("webpack-node-externals");
const {EnvironmentPlugin} = require("webpack");
const {DefinePlugin} = require("webpack");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const {HotModuleReplacementPlugin} = require("webpack");
const DotenvWebpack = require("dotenv-webpack");
const {config: dotenvConfiguration} = require("dotenv");
const NodemonWebpackPlugin = require("nodemon-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const autoprefixer = require("autoprefixer");

dotenvConfiguration();

const PACKAGE_ASSETS = [];
const rootDirectory = [__dirname, "..", ".."];
const sharedDirectory = [...rootDirectory, "lib", "browser"];
const inputDirectory = [...rootDirectory, "lib", "browser_server"];
const outputDirectory = [...rootDirectory, "tmp", "browser"];

module.exports = {
  mode: "development",
  devtool: "inline-source-map",
  module: {
    rules: [
      {
        test: /\.scss$/u,
        use: [
          MiniCssExtractPlugin.loader,
          {loader: "css-loader", options: {importLoaders: 1}},
          {
            loader: "postcss-loader",
            options: {
              plugins () {
                return [
                  autoprefixer,
                ];
              },
            },
          },
          "sass-loader",
        ],
      },
      {
        test: /\.(?:png|jpe?g|gif|xml|txt|json)$/u,
        exclude: /node_modules/u,
        use: {
          loader: "file-loader",
          options: {
            name: "client-[name].[hash].[ext]",
          },
        },
      },
      {
        test: /\.gql$/u,
        exclude: /node_modules/u,
        loader: "graphql-tag/loader",
      },
      {
        test: /\.js$/u,
        exclude: /node_modules/u,
        use: {
          loader: "babel-loader",
        },
      },
    ],
  },
  entry: [
    resolve(...inputDirectory),
  ],
  target: "node",
  node: {
    __dirname: false,
    __filename: false,
  },
  externals: [
    webpackNodeExternals(),
  ],
  output: {
    path: resolve(...outputDirectory),
    filename: "server.js",
  },
  watchOptions: {
    ignored: ["node_modules"],
  },
  resolve: {
    alias: {
      "@clumsy_chinchilla/styles": resolve(...sharedDirectory, "styles"),
      "react-dom": "@hot-loader/react-dom",
    },
  },
  plugins: [
    new DefinePlugin({
      RUNTIME_ENV: "\"server\"",
    }),
    new DotenvWebpack(),
    new EnvironmentPlugin([
      "NODE_ENV",
    ]),
    new HotModuleReplacementPlugin(),
    new CopyWebpackPlugin([{
      from: resolve(...sharedDirectory, "assets"),
      to: resolve(...outputDirectory, "assets"),
    }]),
    ...PACKAGE_ASSETS.map(([from, ...to]) => new CopyWebpackPlugin([{
      from,
      to: resolve(...outputDirectory, "assets", ...to),
    }])),
    new MiniCssExtractPlugin(),
    new NodemonWebpackPlugin({
      watch: resolve(...outputDirectory),
      script: resolve(...outputDirectory, "server.js"),
      ext: "js,html",
    }),
  ],
};
