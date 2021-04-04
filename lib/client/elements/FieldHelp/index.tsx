import type {ReactNode} from "react";

interface PropertiesType {
  id: string;
  children: ReactNode;
}

const styling = {};

export default function FieldHelp (properties: Readonly<PropertiesType>): JSX.Element | null {
  const {id} = properties;
  const {children} = properties;

  if (children === null) {
    return null;
  }

  return <small id={id} css={styling}>{children}</small>;
}
