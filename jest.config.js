/* eslint-disable import/no-commonjs */

module.exports = {
  setupTestFrameworkScriptFile: ".jest/setup.js",
  collectCoverage: true,
  collectCoverageFrom: [
    "./lib/browser/**/index.js",
    "./lib/browser_client/**/index.js",
    "./lib/browser_server/**/index.js",
  ],
};
