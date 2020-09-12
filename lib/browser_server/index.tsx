/* eslint-disable import/no-internal-modules */
/* eslint-disable import/no-nodejs-modules */
import "core-js/stable";
import "regenerator-runtime/runtime";
import {join} from "path";
import {readFileSync} from "fs";
import React from "react";
import {StaticRouter} from "react-router";
import {HelmetProvider} from "react-helmet-async";
import {ApolloProvider} from "@apollo/client";
import {RecoilRoot} from "recoil";
import {renderToStringWithData} from "@apollo/client/react/ssr";
import express from "express";
import cors from "cors";
import morgan from "morgan";
import compression from "compression";
import {parse} from "mustache";
import {render} from "mustache";
import helmet from "helmet";
import {Application} from "@clumsy_chinchilla/elements";
import {RecoilStateHydrater} from "@clumsy_chinchilla/elements";
import logger from "./logger";
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
application.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: [
        "'self'",
        "'unsafe-eval'",
      ],
      scriptSrcElem: [
        "'unsafe-inline'",
        "http://localhost:8080",
        "https://kit.fontawesome.com",
        "https://www.googletagmanager.com",
      ],
      frameSrc: [
        "https://www.googletagmanager.com",
      ],
      styleSrcElem: [
        "'unsafe-inline'",
        "http://localhost:8080",
        "https://fonts.googleapis.com",
        "https://kit-free.fontawesome.com",
      ],
      styleSrc: [
        "'unsafe-inline'",
      ],
      connectSrc: [
        "http://localhost:8080",
        "http://localhost:4000",
        "ws://localhost:8080",
      ],
      fontSrc: [
        "https://fonts.gstatic.com",
        "https://kit-free.fontawesome.com",
      ],
    },
  },
}));
if (process.env.NODE_ENV === "production") {
  application.get("*", function handleHotStar (request, response, next) {
    if (developmentHotFiles.some((pattern) => pattern.test(request.path))) {
      return response.redirect(`http://localhost:8080/${request.path}`);
    }

    return next();
  });
}
application.get("/assets/*", express.static(join(__dirname), {fallthrough: false, index: false}));
application.get("/favicon.ico", express.static(join(__dirname, "assets"), {fallthrough: false, index: false}));
application.get("*", async function handleStar (request, response) {
  const client = sdk(request);
  const routerContext: {url?: string} = {};
  const recoilState = new Map();
  const content = await renderToStringWithData(
    <StaticRouter location={request.url} context={routerContext}>
      <HelmetProvider>
        <RecoilRoot>
          <ApolloProvider client={client}>
            <RecoilStateHydrater mutableState={recoilState}>
              <Application />
            </RecoilStateHydrater>
          </ApolloProvider>
        </RecoilRoot>
      </HelmetProvider>
    </StaticRouter>
  );

  console.log({recoilState});

  response.send(render(template, {
    content,
    googleTagManagerId: "",
    supportEmail: "support@clumsy_chinchilla.com",
    metadata: {
      title: "ClumsyChinchilla",
    },
    recoilHydration: recoilState,
    graphqlHydration: JSON.stringify(client.extract()).replace("<", "\\u003c"),
  }));
  response.end();
});

application.listen(
  process.env.PORT,
  () => {
    logger.info(`Listening to ${process.env.PORT}`);
  }
);
