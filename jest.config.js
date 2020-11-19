/* eslint-disable import/no-commonjs */

module.exports = {
  setupTestFrameworkScriptFile: ".jest/setup.js",
  collectCoverage: true,
  collectCoverageFrom: [
    "./lib/browser/**/index.ts",
    "./lib/browser_client/**/index.ts",
    "./lib/browser_server/**/index.ts",
  ],
};
