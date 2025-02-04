type props_ = {
  auto?: bool,
  enter: (unit => unit) => unit,
  leave: (unit => unit) => unit,
  children: React.element,
}
@module("next-transition-router")
external make: {"default": React.element} = "TransitionRouter"

// https://kapsys.io/user-experience/next-js-page-transitions-creating-smooth-navigation-and-animation
