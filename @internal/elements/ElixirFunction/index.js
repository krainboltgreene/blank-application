import React from "react";
import {useState} from "react";
import SyntaxHighlighter from "react-syntax-highlighter";

import Icon from "../Icon";

export default function ElixirFunction (properties) {
  const {name} = properties;
  const {declaration} = properties;
  const {version} = properties;
  const {slug} = properties;
  const {typespec} = properties;
  const {inputs} = properties;
  const {guards} = properties;
  const {body} = properties;
  const {source} = properties;
  const {documentation} = properties;
  const {elixirModule} = properties;
  const {name: moduleName} = elixirModule;
  const {version: moduleVersion} = elixirModule;
  const {slug: moduleSlug} = elixirModule;
  const [showingTrueSource, setShowingTrueSource] = useState(false);

  if (showingTrueSource) {
    return <section className="card">
      <section>
        <SyntaxHighlighter language="elixir">
          {source}
        </SyntaxHighlighter>
      </section>

      <section className="card-footer text-muted">
        <button className="btn btn-outline-dark" type="button">
          <Icon name="fa-stream" /> <em>22 Observable Events</em>
        </button> <button className="btn btn-outline-dark" type="button" onClick={() => setShowingTrueSource(false)}>
          <Icon name="fa-file-code" /> Hide True Source
        </button>
      </section>
    </section>;
  }

  return <section className="card">
    <section className="card-body">
      <h6 className="card-subtitle">
        <span className="badge badge-info">{moduleName} V{moduleVersion}</span>
      </h6>

      <h3 className="card-title">
        {name} <em className="text-muted"><small>(v{version})</small></em>
      </h3>

      <section className="card-text" css={{"white-space": "pre-wrap"}}>
        <p>
          {documentation}
        </p>
      </section>

      <section className="card-text" css={{"margin-top": "5px", "margin-bottom": "5px"}}>
        <SyntaxHighlighter language="elixir">
          {`@spec ${typespec}`}
        </SyntaxHighlighter>
      </section>

      <section className="card-text" css={{"margin-top": "5px", "margin-bottom": "5px"}}>
        <SyntaxHighlighter language="elixir">
          {`%{${inputs.join(", ")}}`}
        </SyntaxHighlighter>
      </section>

      <section className="card-text" css={{"margin-top": "5px", "margin-bottom": "5px"}}>
        <SyntaxHighlighter language="elixir">
          {`when ${guards.join(" ")}`}
        </SyntaxHighlighter>
      </section>

      <section className="card-text" css={{"margin-top": "5px", "margin-bottom": "5px"}}>
        <SyntaxHighlighter language="elixir">
          {body}
        </SyntaxHighlighter>
      </section>
    </section>

    <section className="card-body">
      <section className="card-text">
        <small className="text-muted"><em>{moduleSlug}.{slug}()</em></small>
      </section>
    </section>

    <section className="card-footer text-muted">
      <button className="btn btn-outline-dark" type="button">
        <Icon name="fa-stream" /> <em>22 Observable Events</em>
      </button> <button className="btn btn-outline-dark" type="button" onClick={() => setShowingTrueSource(!showingTrueSource)}>
        <Icon name="fa-file-code" /> {showingTrueSource ? "Hide" : "Show"} True Source
      </button>
    </section>
  </section>;
}
