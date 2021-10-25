import React from "react";
import type {ErrorInfo} from "react";
import {Component} from "react";
import Exception from "../../Exception";

interface PropertiesType<C> {
  children: C;
}

export default class ErrorBoundary<C> extends Component<Readonly<PropertiesType<C>>, {exception?: Error | string; metadata?: Record<string, unknown>}> {
  private constructor (properties: Readonly<PropertiesType<C>>) {
    super(properties);
    this.state = {};
  }

  public componentDidCatch (exception: Readonly<Error>, errorInfo: Readonly<ErrorInfo>): void {
    this.setState(() => ({exception, metadata: errorInfo}));
  }

  public render (): C | JSX.Element {
    const {children} = this.props;
    const {exception} = this.state;
    if (typeof exception === "undefined") {
      return children;
    }
    const {metadata} = this.state;

    return <Exception kind="overlay" as={exception} metadata={metadata} />;
  }
}
