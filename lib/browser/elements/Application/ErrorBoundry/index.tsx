import React from "react";
import {PureComponent} from "react";
import Exception from "../../Exception";

export default class ErrorBoundry extends PureComponent<{children: React.ReactChildren}, {exception: Error, metadata: {}}> {
  componentDidCatch (exception: Error, metadata: {}) {
    this.setState(() => ({exception, metadata}));
  }

  render () {
    const {children} = this.props;
    const {exception} = this.state;
    const {metadata} = this.state;

    if (exception) {
      return <Exception kind="overlay" as={exception} metadata={metadata} />;
    }

    return children;
  }
}
