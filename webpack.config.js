/* eslint-disable import/no-internal-modules, import/no-commonjs */
const browserClientDevelopment = require("./webpack/browser-client/development.config");
const browserServerDevelopment = require("./webpack/browser-server/development.config");

module.exports = [
  browserClientDevelopment,
  browserServerDevelopment,
];
