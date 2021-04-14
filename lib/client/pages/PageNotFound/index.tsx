import {Page} from "@find_reel_love/elements";

export default function PageNotFound (): JSX.Element {
  return <Page as="PageNotFound" subtitle="Page Not Found" description="This page is for if the content you're requesting is not available.">
    <p>
      I&apos;m sorry, but we couldn&apos;t find that page.
    </p>
  </Page>;
}
