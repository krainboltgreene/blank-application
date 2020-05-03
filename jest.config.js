export const setupTestFrameworkScriptFile = ".jest/setup.js";
export const snapshotSerializers = ["jest-emotion"];
export const collectCoverage = true;
export const collectCoverageFrom = [
  "./client/**/index.js",
  "./@internal/**/index.js",
  "./server/**/index.js",
];
