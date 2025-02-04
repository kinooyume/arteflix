// fix issue with react-aria
// "unhover" & focus inside the tooltip trigger focus change

type props_ = {
  href: string,
  _as?: string,
  prefetch?: bool,
  replace?: bool,
  shallow?: bool,
  passHref?: bool,
  className?: string,
  children: React.element,
}

@react.component(: props_)
type make = (~href: string, ~children: React.element) => React.element
