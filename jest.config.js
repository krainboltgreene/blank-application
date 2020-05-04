/* eslint-disable import/no-commonjs */

module.exports = {
  setupTestFrameworkScriptFile: ".jest/setup.js",
  collectCoverage: true,
  collectCoverageFrom: [
    "./client/**/index.js",
    "./@internal/**/index.js",
    "./server/**/index.js",
  ],
};
