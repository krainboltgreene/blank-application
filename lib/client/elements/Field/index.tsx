/* eslint-disable react/jsx-props-no-spreading */
import React from "react";
import type {ReactNode} from "react";
import type {LabelHTMLAttributes} from "react";
import type {InputHTMLAttributes} from "react";
import FieldHelp from "../FieldHelp";
import FieldFeedback from "../FieldFeedback";

interface PropertiesType {
  scope: string;
  label: string;
  type: string;
  property: string;
  value: string | number | ReadonlyArray<string> | undefined;
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
  const {value} = properties;
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

  return <section className="form-group">
    <label id={labelId} htmlFor={inputId} {...labelAttributes}>{label}</label>
    <input id={inputId} className="form-control" name={name} aria-labelledby={labelId} aria-describedby={helpId} type={type} value={value} {...inputAttributes} />
    <FieldHelp id={helpId}>{help}</FieldHelp>
    <FieldFeedback hasValidated={hasValidated} isValid={isValid}>{feedback}</FieldFeedback>
  </section>;
}
