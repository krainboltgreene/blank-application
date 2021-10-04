/* eslint-disable react/jsx-props-no-spreading */
import React from "react";
import type {ReactNode} from "react";
import type {LabelHTMLAttributes} from "react";
import type {TextareaHTMLAttributes} from "react";
import FieldHelp from "../FieldHelp";
import FieldFeedback from "../FieldFeedback";

interface PropertiesType {
  scope: string;
  label: string;
  type: string;
  property: string;
  help?: string;
  isValid: boolean | null;
  hasValidated: boolean;
  feedback?: ReactNode;
  labelAttributes?: LabelHTMLAttributes<HTMLLabelElement>;
  inputAttributes: Readonly<TextareaHTMLAttributes<HTMLTextAreaElement>>;
}

export default function TextField (properties: Readonly<PropertiesType>): JSX.Element {
  const {scope} = properties;
  const {label} = properties;
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
    <label id={labelId} htmlFor={inputId} {...labelAttributes}>{label}</label>
    <textarea id={inputId} name={name} aria-labelledby={labelId} aria-describedby={helpId} {...inputAttributes} />
    <FieldHelp id={helpId}>{help}</FieldHelp>
    <FieldFeedback hasValidated={hasValidated} isValid={isValid}>{feedback}</FieldFeedback>
  </section>;
}
