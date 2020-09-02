import React from "react";
import Help from "./Help";
import Label from "./Label";
import Input from "./Input";
import Feedback from "./Feedback";

export default function Field (properties) {
  const {scope} = properties;
  const {label} = properties;
  const {value} = properties;
  const {onChange} = properties;
  const {type} = properties;
  const {property} = properties;
  const {help} = properties;
  const {isValid} = properties;
  const {feedback} = properties;
  const {labelAttributes} = properties;
  const {inputAttributes} = properties;
  const inputId = `${scope}-${property}`;
  const name = `${scope}[${property}]`;
  const labelId = `${inputId}-label`;

  if (type === "checkbox" || type === "radio") {
    return <section className="form-group form-check">
      <Input id={inputId} name={name} labelId={inputId} type={type} value={value} onChange={onChange} attributes={inputAttributes} />
      <Label id={labelId} type={type} htmlFor={inputId} attributes={labelAttributes}>{label}</Label>
      <Help id={inputId}>{help}</Help>
      <Feedback isValid={isValid}>{feedback}</Feedback>
    </section>;
  }

  return <section className="form-group">
    <Label id={labelId} type={type} htmlFor={inputId} attributes={labelAttributes}>{label}</Label>
    <Input id={inputId} name={name} labelId={inputId} type={type} value={value} onChange={onChange} attributes={inputAttributes} />
    <Help id={inputId}>{help}</Help>
    <Feedback isValid={isValid}>{feedback}</Feedback>
  </section>;
}
