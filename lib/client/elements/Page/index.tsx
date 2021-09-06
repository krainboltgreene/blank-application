import {Helmet} from "react-helmet-async";
import type {ReactNode} from "react";

const page = "";

interface PropertiesType {
  as: string;
  styling?: string;
  subtitle?: string;
  description?: string;
  kind?: "article";
  children: ReactNode;
}

export default function Page (properties: Readonly<PropertiesType>): JSX.Element {
  const {as} = properties;
  const {styling = ""} = properties;
  const {subtitle = ""} = properties;
  const {description = ""} = properties;
  const {kind} = properties;
  const {children} = properties;
  const titleChange = <Helmet>
    {subtitle ? <title>Clumsy Chinchilla | {subtitle}</title> : null}
    {description ? <meta name="description" content={description} /> : null}
  </Helmet>;

  switch (kind) {
    case "article": {
      return <article className={`${page} ${styling}`} data-component={as}>
        {titleChange}
        {children}
      </article>;
    }
    default: {
      return <main className={`${page} ${styling}`} data-component={as}>
        {titleChange}
        {children}
      </main>;
    }
  }
}
