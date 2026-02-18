open Emotion

module Style = {
  let wrapper =
    ReactDOM.Style.make(
      ~position="fixed",
      ~left="0",
      ~right="0",
      ~top="0",
      ~zIndex="10",
      ~display="flex",
      ~alignItems="center",
      ~justifyContent="center",
      ~background="linear-gradient(180deg, rgba(0, 0, 0, 0.70) 12.5%, rgba(0, 0, 0, 0.00) 100%)",
      (),
    )->css

  let fluid = `
    padding: 0 var(--side-padding);
    height: clamp(48px, 2.5rem + 1.3vw, 68px);
  `->rawCss

  let containt =
    ReactDOM.Style.make(
      ~display="flex",
      ~width="100%",
      ~justifyContent="space-between",
      ~alignItems="center",
      ~flexShrink="0",
      (),
    )->css
}

type headerProps = {
  ...HeaderNav.headerNavProps,
  right?: React.element,
}

@react.component(: headerProps)
let make = (~logo, ~links, ~categories=?, ~categoriesLabel=?, ~right=?) =>
  <header className={[Style.wrapper, Style.fluid]->cx}>
    <div className={Style.containt}>
      <HeaderNav logo links ?categories ?categoriesLabel />
      {switch right {
      | Some(el) => el
      | None => React.null
      }}
    </div>
  </header>
