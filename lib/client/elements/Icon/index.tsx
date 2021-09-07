import {filter} from "ramda";

interface PropertiesType {
  type?: string;
  name: string;
  modifiers?: ReadonlyArray<string>;
}

export default function Icon (properties: Readonly<PropertiesType>): JSX.Element {
  const {type = "fas"} = properties;
  const {name} = properties;
  const {modifiers = []} = properties;
  const cssClasses = filter<string>(Boolean)([type, name, ...modifiers]) as Array<string>;

  return <span className={cssClasses.join(" ")} />;
}
