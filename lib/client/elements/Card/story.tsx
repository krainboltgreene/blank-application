import React, { ComponentProps } from 'react';
import { Story, Meta } from '@storybook/react';
import Card from ".";

//👇 This default export determines where your story goes in the story list
export default {
  title: 'elements/Card',
  component: Card,
} as Meta;

//👇 We create a “template” of how args map to rendering
const Template: Story<ComponentProps<typeof Card>> = (args) => <Card {...args} />;

export const Sample = Template.bind({});
Sample.args = {
  name: "The Ambassador",
  description: "When I finish a project, swap a project.",
  cost: 12,
  leadership: 6,
  wealth: 4,
  planning: 6,
  guile: 4,
};
