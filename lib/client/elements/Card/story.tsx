/* eslint-disable func-style */
import {number} from "@storybook/addon-knobs";
import {text} from "@storybook/addon-knobs";
import Card from ".";

export default {
  component: Card,
  title: "elements/Card",
};

function Template (properties) {
  return <Card {...properties} />;
}
export const Default = Template.bind({});

Default.args = {
  name: "The Ambassador",
  description: "When I finish a project, swap a project.",
  cost: 12,
  leadership: 6,
  wealth: 4,
  planning: 6,
  guile: 4,
};

// export function sample (): JSX.Element {
//   return <BrowserRouter>
//     <Card

// name text("name", "The Ambassador"),
//       description={text("description", "When I finish a project, swap a project.")}
//       cost={number("cost", 12)}
//       leadership={number("leadership", 6)}
//       wealth={number("wealth", 4)}
//       planning={number("planning", 6)}
//       guile={number("guile", 4)}
//     />
//   </BrowserRouter>;
// }
