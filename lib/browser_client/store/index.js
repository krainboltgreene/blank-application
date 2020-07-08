import {init} from "@rematch/core";
import {createLogger} from "redux-logger";

import {database} from "@clumsy_chinchilla/models";

export default init({
  models: {
    database,
  },
  redux: {
    middlewares: process.env.NODE_ENV === "production" ? [] : [createLogger({collapsed: true, duration: true})],
  },
});
