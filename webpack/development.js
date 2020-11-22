/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable import/no-commonjs */
/* eslint-disable import/no-nodejs-modules */

const path = require("path");
const {HotModuleReplacementPlugin} = require("webpack");
const {EnvironmentPlugin} = require("webpack");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const WebpackAssetsManifest = require("webpack-assets-manifest");
const CopyWebpackPlugin = require("copy-webpack-plugin");
// const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const ExtractCssChunksWebpackPlugin = require("extract-css-chunks-webpack-plugin");
const SizePlugin = require("size-plugin");
// Helpful constants
const ROOT_DIRECTORY = [__dirname, ".."];
const ASSETS_DIRECTORY = [...ROOT_DIRECTORY, "assets"];
const CLIENT_DIRECTORY = [...ROOT_DIRECTORY, "lib", "client"];
const OUTPUT_DIRECTORY = [...ROOT_DIRECTORY, "tmp", "browser-client"];
const PACKAGE_ASSETS = [];

module.exports = {
  mode: "development",
  devtool: "inline-source-map",
  module: {
    rules: [
      {
        test: /\.global\.scss$/u,
        use: [
          {loader: ExtractCssChunksWebpackPlugin.loader, options: {hmr: true}},
          {loader: "css-loader", options: {importLoaders: 1}},
          "postcss-loader",
        ],
      },
      {
        test: /\.scss$/u,
        use: [
          // Move to production MiniCssExtractPlugin.loader,
          "style-loader",
          {loader: "css-loader", options: {importLoaders: 1}},
          "sass-loader",
        ],
      },
      {
        test: /\.(?:png|jpe?g|gif|xml|txt|json)$/u,
        exclude: /node_modules/u,
        use: {
          loader: "file-loader",
          options: {
            name: "[name].[contenthash].[ext]",
          },
        },
      },
      {
        test: /\.gql$/u,
        exclude: /node_modules/u,
        loader: "graphql-tag/loader",
      },
      {
        test: /\.tsx?$/u,
        exclude: /node_modules/u,
        use: {
          loader: "babel-loader",
        },
      },
    ],
  },
  entry: [
    "react-hot-loader/patch",
    path.resolve(...CLIENT_DIRECTORY, "index.tsx"),
  ],
  target: "web",
  output: {
    publicPath: "http://localhost:8080/",
    path: path.resolve(...OUTPUT_DIRECTORY),
    filename: "browser-client.js",
  },
  devServer: {
    hot: true,
    historyApiFallback: true,
    headers: {"Access-Control-Allow-Origin": "*"},
  },
  watchOptions: {
    ignored: ["node_modules"],
  },
  resolve: {
    extensions: [".tsx", ".ts", ".js", ".jsx"],
    alias: {
      "@clumsy_chinchilla/styles": path.resolve(...CLIENT_DIRECTORY, "styles"),
      "react-dom": "@hot-loader/react-dom",
    },
  },
  plugins: [
    new EnvironmentPlugin([
      "NODE_ENV",
    ]),
    new SizePlugin(),
    new HotModuleReplacementPlugin(),
    ...PACKAGE_ASSETS.map(([from, ...to]) => new CopyWebpackPlugin([{
      from,
      to: path.resolve(...OUTPUT_DIRECTORY, "assets", ...to),
    }])),
    new CopyWebpackPlugin({
      patterns: [{
        from: path.resolve(...ASSETS_DIRECTORY),
        to: path.resolve(...OUTPUT_DIRECTORY, "assets"),
      }],
    }),
    // new MiniCssExtractPlugin(),
    new ExtractCssChunksWebpackPlugin(),
    new WebpackAssetsManifest({
      output: "asset-integrity-manifest.json",
      integrity: false,
    }),
    new HtmlWebpackPlugin({
      hash: true,
      title: "Clumsy Chinchilla",
      base: "http://localhost:8080/",
      templateParameters: {
        metadata: {
          applicationName: "applicationName",
          themeColor: "themeColor",
          description: "description",
          googleSiteVerification: "googleSiteVerification",
          yandexVerification: "yandexVerification",
          bingWebmasterVerification: "bingWebmasterVerification",
          alexaConsoleVerification: "alexaConsoleVerification",
          pinterestConsoleVerification: "pinterestConsoleVerification",
          nortonSafewebVerification: "nortonSafewebVerification",
          googleTagManagerId: "googleTagManagerId",
          supportEmailAddress: "supportEmailAddress",
        },
      },
      template: path.resolve(...CLIENT_DIRECTORY, "templates", "index.html"),
    }),
  ],
};
