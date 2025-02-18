module Chevron = {
  type props_ = {color: string, size: string}
  @module("./Chevron.jsx") @react.component(: props_)
  external make: unit => React.element = "default"
}

module Triangle = {
  @module("./BlackTriangle.jsx") @react.component
  external make: unit => React.element = "default"
}

module OverlayPlay = {
  @module("./CardOverlayPlayIcon.jsx") @react.component
  external make: unit => React.element = "default"
}

module Dot = {
  type props_ = {color: string}
  @module("./Dot.jsx") @react.component(: props_)
  external make: unit => React.element = "default"
}
