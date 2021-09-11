const {build} = require('esbuild');
const {default: graphqlLoaderPlugin} = require('@luckycatfactory/esbuild-graphql-loader');

build({
  entryPoints: ['lib/client'],
  logLevel: "info",
  define: {
    global: "window"
  },
  watch: !!process.env.WATCHING,
  bundle: true,
  outfile: 'priv/static/assets/js/application.js',
  plugins: [graphqlLoaderPlugin()],
}).catch(() => process.exit(1));
