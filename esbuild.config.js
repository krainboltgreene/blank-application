const {build} = require('esbuild');
const {default: graphqlLoaderPlugin} = require('@luckycatfactory/esbuild-graphql-loader');

build({
  entryPoints: ['lib/client'],
  define: {
    global: "window"
  },
  bundle: true,
  outfile: 'priv/static/js/application.js',
  plugins: [graphqlLoaderPlugin()],
}).catch(() => process.exit(1));
