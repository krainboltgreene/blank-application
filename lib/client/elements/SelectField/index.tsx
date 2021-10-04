/* eslint-disable react/jsx-props-no-spreading */
import React from "react";
import type {ReactNode} from "react";
import type {LabelHTMLAttributes} from "react";
import type {SelectHTMLAttributes} from "react";
import {map} from "ramda";
import FieldHelp from "../FieldHelp";
import FieldFeedback from "../FieldFeedback";

interface PropertiesType {
  scope: string;
  label: string;
  type: string;
  property: string;
  options: Readonly<Array<{key: string; option: string}>>;
  value: string;
  help?: string;
  isValid: boolean | null;
  hasValidated: boolean;
  feedback?: ReactNode;
  labelAttributes?: LabelHTMLAttributes<HTMLLabelElement>;
  inputAttributes: Readonly<SelectHTMLAttributes<HTMLSelectElement>>;
}

export default function SelectField (properties: Readonly<PropertiesType>): JSX.Element {
  const {scope} = properties;
  const {label} = properties;
  const {property} = properties;
  const {options} = properties;
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

  // TODO: Handle select change
  return <section className="col-md-6">
    <select id={inputId} name={name} aria-labelledby={labelId} aria-describedby={helpId} {...inputAttributes}>
      {
        map(
          ({key, option}: Readonly<{key: string; option: string}>) => <option value={option} selected={value === key}>{key}</option>
        )(options)
      }
    </select>
    <label id={labelId} htmlFor={inputId} {...labelAttributes}>{label}</label>
    <FieldHelp id={helpId}>{help}</FieldHelp>
    <FieldFeedback hasValidated={hasValidated} isValid={isValid}>{feedback}</FieldFeedback>
  </section>;
}
