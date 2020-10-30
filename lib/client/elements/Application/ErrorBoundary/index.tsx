import React from "react";
import type {ReactNode} from "react";
import type {ErrorInfo} from "react";
import {Component} from "react";
import Exception from "../../Exception";

export default class ErrorBoundary extends Component<Readonly<{children: ReactNode}>, {exception: Error | string; metadata?: Record<string, unknown>} | null> {
  public componentDidCatch (exception: Readonly<Error>, errorInfo: Readonly<ErrorInfo>): void {
    this.setState(() => ({exception, metadata: errorInfo}));
  }

  public render (): ReactNode | JSX.Element {
    const {children} = this.props;

    if (this.state === null) {
      return children;
    }

    const {exception} = this.state;
    const {metadata} = this.state;

    return <Exception kind="overlay" as={exception} metadata={metadata} />;
  }
}
