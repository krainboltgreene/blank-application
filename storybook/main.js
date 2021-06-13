/* eslint-disable import/no-commonjs */
/* eslint-disable import/no-nodejs-modules */
const path = require("path");

module.exports = {
  reactOptions: {
    fastRefresh: true,
    // strictMode: true,
  },
  stories: [path.resolve(__dirname, "..", "lib", "client", "**", "story.tsx")],
  addons: [
    "@storybook/addon-a11y/register",
    "@storybook/addon-knobs/register",
    {
      name: "@storybook/addon-storysource",
      options: {
        rule: {
          test: [/story\.tsx?$/u],
          include: [path.resolve(__dirname, "..", "lib", "client")],
        },
      },
    },
  ],
};
