import {init} from "@rematch/core";
import {createLogger} from "redux-logger";

export default init({
  models: {},
  redux: {
    middlewares: [createLogger({collapsed: true, duration: true})],
  },
});
