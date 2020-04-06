import React from "react"
// import {Provider} from "react-redux"
import {addDecorator} from "@storybook/react"
import {configure} from '@storybook/react'
import {checkA11y} from "@storybook/addon-a11y"
import {withKnobs} from "@storybook/addon-knobs"
// import {withTests} from "@storybook/addon-jest"
// import rematch from "@internal/rematch"
// import results from "./jest-test-results.json"

// automatically import all files ending in *.stories.js
const requireWithContext = require.context('../@internal', true, /story\.js$/);

addDecorator(withTests({results}))
addDecorator(withKnobs)
addDecorator(checkA11y)
// addDecorator((story) => {
//   return <Provider store={rematch}>
//     {story()}
//   </Provider>
// })

configure(() => requireWithContext.keys().forEach((filename) => requireWithContext(filename)), module);
