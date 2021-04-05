const path = require("path");
const ReactRefreshWebpackPlugin = require('@pmmmwh/react-refresh-webpack-plugin');
const {EnvironmentPlugin} = require("webpack");
const {BundleAnalyzerPlugin} = require("webpack-bundle-analyzer");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const WebpackAssetsManifest = require("webpack-assets-manifest");
const CopyWebpackPlugin = require("copy-webpack-plugin");

// Helpful constants
const ROOT_DIRECTORY = [__dirname, ".."];
const ASSETS_DIRECTORY = [...ROOT_DIRECTORY, "assets"];
const CLIENT_DIRECTORY = [...ROOT_DIRECTORY, "lib", "client"];
const OUTPUT_DIRECTORY = [...ROOT_DIRECTORY, "tmp", "browser-client"];
const PACKAGE_ASSETS = [];
const ASSET_LOADER = {
  loader: "file-loader",
  options: {
    name: "[name].[ext]",
  },
}
const CI = process.env.GITHUB_ACTIONS === "true";
const HOTLOADED = process.env.HOT === "enabled";

module.exports = {
  mode: "development",
  devtool: CI ? false : "eval-cheap-module-source-map",
  target: "web",
  cache: CI ? {
    type: 'filesystem'
  } : true,
  watch: HOTLOADED,
  watchOptions: {
    ignored: ["node_modules"],
  },
  entry: [
    path.resolve(...CLIENT_DIRECTORY, "index.tsx"),
  ],
  resolve: {
    symlinks: false,
    extensions: [".tsx", ".ts", ".js", ".jsx"],
  },
  module: {
    rules: [
      {
        test: /\.(?:gif|xml|txt|json)$/iu,
        include: path.resolve(...ASSETS_DIRECTORY),
        use: [ASSET_LOADER],
      },
      {
        test: /\.(?:png|webp|jpe?g)$/iu,
        include: path.resolve(...ASSETS_DIRECTORY),
        use: [ASSET_LOADER, "webp-loader"],
      },
      {
        test: /\.gql$/iu,
        include: path.resolve(...CLIENT_DIRECTORY),
        use: ["graphql-tag/loader"],
      },
      {
        test: /\.(?:ts|js)x?$/iu,
        include: path.resolve(...CLIENT_DIRECTORY),
        use: ["babel-loader"],
      },
    ],
  },
  output: {
    publicPath: "http://localhost:8080/",
    path: path.resolve(...OUTPUT_DIRECTORY),
    filename: "browser-client.js",
  },
  optimization: {
    runtimeChunk: true,
    splitChunks: {
      chunks: 'async'
    },
  },
  devServer: {
    hot: HOTLOADED,
    historyApiFallback: true,
    headers: {"Access-Control-Allow-Origin": "*"},
  },
  plugins: [
    new EnvironmentPlugin({
      NODE_ENV: "development"
    }),
    HOTLOADED && new ReactRefreshWebpackPlugin(),
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
    !HOTLOADED && !CI && new BundleAnalyzerPlugin()
  ].filter(Boolean),
};
