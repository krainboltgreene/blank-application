/* eslint-disable import/no-commonjs */
/* eslint-disable import/no-nodejs-modules */
const path = require("path");

module.exports = {
  stories: ["../lib/client/**/story.ts"],
  addons: [
    "@storybook/addon-a11y/register",
    "@storybook/addon-knobs/register",
    {
      name: "@storybook/addon-storysource",
      options: {
        rule: {
          test: [/story\.ts?$/u],
          include: [path.resolve(__dirname, "..", "lib", "client")],
        },
      },
    },
  ],
};
