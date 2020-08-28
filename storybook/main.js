/* eslint-disable import/no-commonjs */
/* eslint-disable import/no-nodejs-modules */
const {resolve} = require("path");

module.exports = {
  stories: ["../lib/browser/**/story.ts"],
  addons: [
    "@storybook/addon-a11y/register",
    "@storybook/addon-knobs/register",
    {
      name: "@storybook/addon-storysource",
      options: {
        rule: {
          test: [/story\.ts?$/u],
          include: [resolve(__dirname, "..", "lib", "browser")],
        },
      },
    },
  ],
};
