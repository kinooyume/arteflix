module RouterProvider = {
  type props_ = {
    navigate: (string, option<ReactAria.routerOptions>) => unit,
    children: React.element,
  }

  @module("react-aria-components") @react.component(: props_)
  external make: props_ => React.element = "RouterProvider"
}
