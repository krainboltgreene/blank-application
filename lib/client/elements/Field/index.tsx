/* eslint-disable react/jsx-props-no-spreading */
import React from "react";
import type {ReactNode} from "react";
import type {LabelHTMLAttributes} from "react";
import type {InputHTMLAttributes} from "react";
import FieldHelp from "../FieldHelp";
import FieldFeedback from "../FieldFeedback";

interface PropertiesType {
  type: string;
  scope: string;
  label: string;
  property: string;
  help?: string;
  isValid?: boolean | null;
  hasValidated: boolean;
  feedback?: ReactNode;
  labelAttributes?: LabelHTMLAttributes<HTMLLabelElement>;
  inputAttributes: Readonly<InputHTMLAttributes<HTMLInputElement>>;
}

export default function Field (properties: Readonly<PropertiesType>): JSX.Element {
  const {scope} = properties;
  const {label} = properties;
  const {type} = properties;
  const {property} = properties;
  const {help} = properties;
  const {isValid = null} = properties;
  const {hasValidated = false} = properties;
  const {feedback} = properties;
  const {labelAttributes} = properties;
  const {inputAttributes} = properties;
  const inputId = `${scope}-${property}`;
  const name = `${scope}[${property}]`;
  const labelId = `${inputId}-label`;
  const helpId = `${inputId}-help`;

  return <section className="col-md-6">
    <label id={labelId} htmlFor={inputId} className="form-label" {...labelAttributes}>{label}</label>
    <input id={inputId} name={name} aria-labelledby={labelId} aria-describedby={helpId} type={type} className="form-control" {...inputAttributes} />
    <FieldHelp id={helpId}>{help}</FieldHelp>
    <FieldFeedback hasValidated={hasValidated} isValid={isValid}>{feedback}</FieldFeedback>
  </section>;
}
