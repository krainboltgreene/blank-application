import React from "react";
import {lifecycle} from "recompose";
import Exception from "../../Exception";

export default lifecycle({
  componentDidCatch (exception: Error, metadata: {}) {
    this.setState(() => ({exception, metadata}));
  },
})(function ErrorBoundry ({exception, metadata, children}) {
  if (exception) {
    return <Exception kind="overlay" as={exception} metadata={metadata} />;
  }

  return children;
});
