import React from 'react'
import { shallow } from 'enzyme'

import Example from './example.js.js'

it('renders without props', () => {
    shallow( < Example / > )
})