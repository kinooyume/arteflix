module Motion = {
  type transition = {duration?: float}

  type animate = {
    opacity?: float,
    width?: string,
    height?: string,
    transform?: string,
    margin?: string,
    overflow?: string,
    scale?: float,
    transition?: transition,
  }

  type props_ = {
    key?: string,
    initial?: animate,
    animate?: animate,
    exit?: animate,
    children: React.element,
  }

  @module("framer-motion") @scope("motion") @react.component(: props_)
  external div: props_ => React.element = "div"
}

module AnimatePresence = {
  type props_ = {children: React.element, mode?: [#wait | #sync | #popLayout]}
  @module("framer-motion") @react.component(: props_)
  external make: props_ => React.element = "AnimatePresence"
}

module Hooks = {
  @module("framer-motion")
  external usePresence: unit => (bool, unit => unit) = "usePresence"
}

// import { motion, AnimatePresence } from "framer-motion"
