import React from "react";
import {lifecycle} from "recompose";
import Exception from "../../Exception";

export default lifecycle({
  componentDidCatch (exception, info) {
    this.setState(() => ({exception, info}));
  },
})(function ErrorBoundry ({exception, info, children}) {
  if (exception) {
    return <Exception kind="overlay" as={exception} metadata={info} />;
  }

  return children;
});
