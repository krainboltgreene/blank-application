/* eslint-disable react/jsx-props-no-spreading */
import React from "react";
import Interface from "./Interface";

export default function Field (properties) {
  const {scope} = properties;
  const {label} = properties;
  const {type} = properties;
  const {as} = properties;
  const {labelAttributes} = properties;
  const {inputAttributes} = properties;
  const inputId = `${scope}-${as}`;

  return <section>
    <Interface type={type} label={label} inputId={inputId} inputAttributes={inputAttributes} labelAttributes={labelAttributes} />
  </section>;
  // const {scope, label, attribute, type, description, invalidFeedback, validFeedback, labelAttributes, inputAttributes} = properties;
  // const inputId = `${scope}-${attribute}`;
  // const name = `${scope}[${attribute}]`;
  // const labelId = `${inputId}-label`;
  // const descriptionId = `${inputId}-description`;
  // const labelComponent = <Label name={name} labelId={labelId} {...labelAttributes}>{label}</Label>;
  // const inputComponent = <Input name={name} labelId={labelId} {...inputAttributes} />;

  // return <section>
  //   <Interface type={type} labelComponent={labelComponent} inputComponent={inputComponent} />
  //   {description && <small id={descriptionId} className="form-text text-muted">{description}</small>}
  //   {invalidFeedback && <p className="invalid-feedback">
  //     {invalidFeedback}
  //   </p>}
  //   {validFeedback && <p className="valid-feedback">
  //     {validFeedback}
  //   </p>}
  // </section>;
}
