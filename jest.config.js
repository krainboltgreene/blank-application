/* eslint-disable import/no-commonjs */

module.exports = {
  setupTestFrameworkScriptFile: ".jest/setup.js",
  collectCoverage: true,
  collectCoverageFrom: [
    "./lib/client/**/index.ts",
  ],
};
