const path = require("path");

module.exports = {
  reactOptions: {
    fastRefresh: true,
    // strictMode: true,
  },
  stories: [path.resolve(__dirname, "..", "lib", "client", "**", "story.tsx")],
  addons: [],
};
