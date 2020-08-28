import {init} from "@rematch/core";
import {createLogger} from "redux-logger";

export default init({
  models: {},
  redux: {
    middlewares: process.env.NODE_ENV === "production" ? [] : [createLogger({collapsed: true, duration: true})],
  },
});
