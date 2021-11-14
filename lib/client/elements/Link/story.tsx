import React, { ComponentProps } from 'react';
import { Story, Meta } from '@storybook/react';
import {BrowserRouter} from "react-router-dom";
import Link from ".";

export default {
  title: 'elements/Link',
  component: Link,
} as Meta;

const Template: Story<ComponentProps<typeof Link>> = (args) => <BrowserRouter><Link {...args}>{args.children}</Link></BrowserRouter>;

export const WithRemoteHref = Template.bind({});
WithRemoteHref.args = {
  href: "https://example.com",
  children: "Example link"
};
export const WithInternalHref = Template.bind({});
WithRemoteHref.args = {
  href: "/login",
  children: "Example link"
};
