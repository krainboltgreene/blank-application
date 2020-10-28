import {PureComponent} from "react";
import Exception from "../../Exception";

export default class ErrorBoundary extends PureComponent<{children: React.ReactNode}, {exception: Error, metadata: {}}> {
  componentDidCatch (exception: Error, metadata: {}) {
    this.setState(() => ({exception, metadata}));
  }

  render () {
    const {children} = this.props;

    if (!this.state) {
      return children;
    }

    const {exception} = this.state;
    const {metadata} = this.state;

    if (exception) {
      return <Exception kind="overlay" as={exception} metadata={metadata} />;
    }

    return children;
  }
}
