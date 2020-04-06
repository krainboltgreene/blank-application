/* eslint-disable import/no-commonjs, import/no-nodejs-modules, func-style */

const path = require("path");
const {HashedModuleIdsPlugin} = require("webpack");
const {HotModuleReplacementPlugin} = require("webpack");
// const WebpackNodeExternals = require("webpack-node-externals");
const {IgnorePlugin} = require("webpack");
const {EnvironmentPlugin} = require("webpack");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const CompressionWebpackPlugin = require("compression-webpack-plugin");
const {CleanWebpackPlugin} = require("clean-webpack-plugin");
const {BundleAnalyzerPlugin} = require("webpack-bundle-analyzer");
const {Plugin: WebpackCommonShake} = require("webpack-common-shake");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const WebpackAssetsManifest = require("webpack-assets-manifest");
const WebpackSubresourceIntegrity = require("webpack-subresource-integrity");
const DotenvWebpack = require("dotenv-webpack");
const {config: dotenvConfiguration} = require("dotenv");
const {compact} = require("@unction/complete");
const {mergeDeepRight} = require("@unction/complete");

dotenvConfiguration();

const BENCHMARK = process.env.BENCHMARK === "enabled";
const NODE_ENV = process.env.NODE_ENV || "development";
const PRODUCTION = NODE_ENV === "production";
const DEVTOOL = PRODUCTION ? "source-map" : "inline-source-map";
const PACKAGE_ASSETS = [];
const SHARED_BUILD_CONFIGURATION = {
  mode: NODE_ENV,
  devtool: DEVTOOL,
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
};
const PRE_SHARED_PLUGINS = [
  PRODUCTION ? null : new DotenvWebpack(),
  new EnvironmentPlugin([
    "NODE_ENV",
    "BENCHMARK",
    "COUCHDB_USERNAME",
    "COUCHDB_PASSWORD",
    "COUCHDB_URI",
  ]),
  PRODUCTION ? new CleanWebpackPlugin({verbose: true}) : null,
];
const POST_SHARED_PLUGINS = [
  PRODUCTION ? new CompressionWebpackPlugin({
    filename: "[path].br[query]",
    algorithm: "brotliCompress",
    compressionOptions: {level: 11},
    test: /\.(?:js|css|txt|xml|json|png|svg|jpg|gif|woff|woff2|eot|ttf|otf)$/iu,
  }) : null,
  PRODUCTION ? new CompressionWebpackPlugin({
    test: /\.(?:js|css|txt|xml|json|png|svg|jpg|gif|woff|woff2|eot|ttf|otf)$/iu,
  }) : null,
  new WebpackCommonShake(),
  BENCHMARK ? new BundleAnalyzerPlugin({analyzerMode: "static", openAnalyzer: false}) : null,
];

function clientFor (name, target, configuration = {}) {
  return mergeDeepRight({
    ...SHARED_BUILD_CONFIGURATION,
    entry: [
      `./${name}/index.js`,
    ],
    target,
    output: {
      publicPath: PRODUCTION ? "/assets/" : "/",
      path: path.resolve(__dirname, "tmp", name.split("-")[0], PRODUCTION ? "assets" : ""),
      filename: "[name].[hash].js",
      chunkFilename: "[id].[chunkhash].js",
    },
    optimization: {
      minimize: PRODUCTION,
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
      contentBase: path.join(__dirname, "tmp", name.split("-")[0]),
      compress: true,
      historyApiFallback: true,
      hot: true,
      overlay: true,
    },
    plugins: compact([
      ...PRE_SHARED_PLUGINS,
      new CopyWebpackPlugin([{
        from: path.resolve(__dirname, "assets"),
        to: path.resolve(__dirname, "tmp", name.split("-")[0], "assets"),
      }]),
      ...PACKAGE_ASSETS.map(([from, ...to]) => new CopyWebpackPlugin([{
        from,
        to: path.resolve(__dirname, "tmp", name.split("-")[0], "assets", ...to),
      }])),
      PRODUCTION ? null : new HotModuleReplacementPlugin(),
      PRODUCTION ? new IgnorePlugin(/^\.\/locale$/u, /moment$/u) : null,
      new HtmlWebpackPlugin({
        minify: {
          removeComments: true,
          collapseWhitespace: true,
          removeRedundantAttributes: true,
          useShortDoctype: true,
          removeEmptyAttributes: true,
          minifyJS: true,
          minifyCSS: true,
        },
        hash: true,
        template: path.join(__dirname, "..", "..", "templates", "index.html"),
      }),
      new HashedModuleIdsPlugin(),
      PRODUCTION ? new WebpackSubresourceIntegrity({
        hashFuncNames: ["sha256", "sha384"],
        enabled: true,
      }) : null,
      new WebpackAssetsManifest({
        output: "asset-integrity-manifest.json",
        integrity: PRODUCTION,
      }),
      ...POST_SHARED_PLUGINS,
    ]),
  })(
    configuration
  );
}
function serverFor (name, target, configuration = {}) {
  return mergeDeepRight({
    ...SHARED_BUILD_CONFIGURATION,
    entry: [
      `./${name}/index.js`,
    ],
    target,
    node: {
      __dirname: false,
      __filename: false,
    },
    output: {
      path: path.resolve(__dirname, "tmp", name.split("-")[0]),
    },
    optimization: {
      minimize: PRODUCTION,
    },
    plugins: compact([
      ...PRE_SHARED_PLUGINS,
      PRODUCTION ? new IgnorePlugin(/^\.\/locale$/u, /moment$/u) : null,
      new CopyWebpackPlugin([{
        from: path.resolve(__dirname, "assets"),
        to: path.resolve(__dirname, "tmp", name.split("-")[0], "assets"),
      }]),
      ...PACKAGE_ASSETS.map(([from, ...to]) => new CopyWebpackPlugin([{
        from,
        to: path.resolve(__dirname, "tmp", name.split("-")[0], "assets", ...to),
      }])),
      ...POST_SHARED_PLUGINS,
    ]),
  })(
    configuration
  );
}

module.exports = [
  clientFor("browser-client", "web", {
    devServer: {
      port: 9000,
    },
  }),
  // clientFor("desktop-client", "electron-renderer", {
  //   devServer: {
  //     port: 9001,
  //   },
  // }),
  serverFor("browser-server", "node"),
  // serverFor("desktop-server", "electron-renderer"),
];
