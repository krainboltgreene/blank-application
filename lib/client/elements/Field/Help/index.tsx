/* eslint-disable unicorn/no-null */
import {ReactNode} from "react";
import "./index.scss";

type PropertiesType = {
  id: string,
  children: ReactNode
}

export default function Help (properties: PropertiesType) {
  const {id} = properties;
  const {children} = properties;

  if (children) {
    return <small id={`${id}-help`} className="Help">{children}</small>;
  }

  return null;
}
