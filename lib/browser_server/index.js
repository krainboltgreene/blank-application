/* eslint-disable import/no-internal-modules */
/* eslint-disable import/no-nodejs-modules */
import "core-js/stable";
import "regenerator-runtime/runtime";
import {join} from "path";
import {readFileSync} from "fs";
import React from "react";
import {Provider as ReduxProvider} from "react-redux";
import {StaticRouter} from "react-router";
import {HelmetProvider} from "react-helmet-async";
import {ApolloProvider} from "@apollo/client";
import {RecoilRoot} from "recoil";
import {renderToString} from "react-dom/server";
import express from "express";
import cors from "cors";
import morgan from "morgan";
import compression from "compression";
import {parse} from "mustache";
import {render} from "mustache";
import helmet from "helmet";
import {Application} from "@clumsy_chinchilla/elements";
import logger from "./logger";
import store from "./store";
import sdk from "./sdk";

const developmentHotFiles = [
  /client\.js/u,
  /main\.css/u,
  /hot-update\.json/u,
];
const template = readFileSync(join(__dirname, "index.html"), "utf8");
const application = express();

parse(template);

application.use(morgan(process.env.NODE_ENV === "production" ? "combined" : "dev"));
application.use(compression());
application.use(cors());
application.use(helmet());
if (process.env.NODE_ENV === "production") {
  application.get("*", function handleHotStar (request, response, next) {
    if (developmentHotFiles.some((pattern) => pattern.test(request.path))) {
      return response.redirect(`http://localhost:8080/${request.path}`);
    }

    return next();
  });
}


application.get(express.static(join(__dirname, "assets"), {fallthrough: true, index: false}));
application.get("/assets", express.static(join(__dirname, "assets"), {fallthrough: false, index: false}));
application.get("*", function handleStar (request, response) {
  const routerContext = {};
  const content = renderToString(
    <StaticRouter location={request.url} context={routerContext}>
      <HelmetProvider>
        <RecoilRoot>
          <ReduxProvider store={store}>
            <ApolloProvider client={sdk}>
              <Application />
            </ApolloProvider>
          </ReduxProvider>
        </RecoilRoot>
      </HelmetProvider>
    </StaticRouter>
  );

  if (routerContext.url) {
    return 400;
  }

  return response.send(render(template, {
    content,
    googleTagManagerId: "",
    supportEmail: "support@clumsy_chinchilla.com",
    metadata: {
      title: "ClumsyChinchilla",
    },
  }));
});

application.listen(
  process.env.PORT,
  () => {
    logger.info(`Listening to ${process.env.PORT}`);
  }
);
