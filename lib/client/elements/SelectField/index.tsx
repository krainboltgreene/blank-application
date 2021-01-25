/* eslint-disable react/jsx-props-no-spreading */
import type {ReactNode} from "react";
import type {LabelHTMLAttributes} from "react";
import type {SelectHTMLAttributes} from "react";
import {mapValues} from "@unction/complete";
import FieldHelp from "../FieldHelp";
import FieldFeedback from "../FieldFeedback";

interface PropertiesType<V> {
  scope: string;
  label: string;
  type: string;
  property: string;
  options: Readonly<Record<string, V>>;
  value: V;
  help?: string;
  isValid: boolean | null;
  hasValidated: boolean;
  feedback?: ReactNode;
  labelAttributes?: LabelHTMLAttributes<HTMLLabelElement>;
  inputAttributes: Readonly<SelectHTMLAttributes<HTMLSelectElement>>;
}

export default function SelectField<V> (properties: Readonly<PropertiesType<V>>): JSX.Element {
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
  return <section>
    <select id={inputId} name={name} aria-labelledby={labelId} aria-describedby={helpId} {...inputAttributes}>
      {
        mapValues(
          ({key, option}: Readonly<{key: string; option: string | number | ReadonlyArray<string>}>) => <option value={option} selected={value === key}>{key}</option>
        )(options)
      }
    </select>
    <label id={labelId} htmlFor={inputId} {...labelAttributes}>{label}</label>
    <FieldHelp id={helpId}>{help}</FieldHelp>
    <FieldFeedback hasValidated={hasValidated} isValid={isValid}>{feedback}</FieldFeedback>
  </section>;
}
