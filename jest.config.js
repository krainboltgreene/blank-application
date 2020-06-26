/* eslint-disable import/no-commonjs */

module.exports = {
  setupTestFrameworkScriptFile: ".jest/setup.js",
  collectCoverage: true,
  collectCoverageFrom: [
    "./apps/browser/lib/**/index.js",
    "./apps/browser_client/lib/**/index.js",
    "./apps/browser_server/lib/**/index.js",
  ],
};
