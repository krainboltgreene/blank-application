const {build} = require('esbuild');
const {default: graphqlLoaderPlugin} = require('@luckycatfactory/esbuild-graphql-loader');
const postcss = require("esbuild-postcss")

build({
  entryPoints: ['lib/client'],
  bundle: true,
  outfile: 'priv/static/js/application.js',
  plugins: [graphqlLoaderPlugin(), postcss()],
}).catch(() => process.exit(1));
