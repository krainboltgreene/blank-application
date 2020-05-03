/* eslint-disable import/no-commonjs */
/* eslint-disable import/no-nodejs-modules */
const {resolve} = require("path");

module.exports = {
  stories: ["../@internal/**/story.js"],
  addons: [
    "@storybook/addon-a11y/register",
    "@storybook/addon-knobs/register",
    {
      name: "@storybook/addon-storysource",
      options: {
        rule: {
          test: [/story\.js?$/u],
          include: [resolve(__dirname, "..", "@internal")],
        },
      },
    },
    // "@storybook/addon-actions/register",
    // "@storybook/addon-console",
    // "@storybook/addon-links/register",
    // "@storybook/addon-viewport/register",
    // "@storybook/addon-docs",
  ],
};
