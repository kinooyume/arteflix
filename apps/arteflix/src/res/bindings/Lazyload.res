type props_ = {
  height?: int,
  once?: bool,
  offset?: int,
  debounce?: int,
  throttle?: int,
  unmountIfInvisible?: bool,
  classNamePrefix?: string,
  children: React.element,
}

@module("react-lazyload") @react.component(: props_)
external make: props_ => React.element = "default"
