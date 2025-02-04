open Emotion

module Style = {
  let wrapper =
    ReactDOM.Style.make(
      ~position="fixed",
      ~left="0",
      ~right="0",
      ~top="0",
      ~zIndex="10",
      ~height="68px",
      ~padding="0 58px",
      ~display="flex",
      ~alignItems="center",
      ~justifyContent="center",
      ~background="linear-gradient(180deg, rgba(0, 0, 0, 0.70) 12.5%, rgba(0, 0, 0, 0.00) 100%)",
      (),
    )->css
  let containt =
    ReactDOM.Style.make(
      ~display="flex",
      ~width="100%",
      ~height="25px",
      ~justifyContent="space-between",
      ~alignItems="center",
      ~flexShrink="0",
      (),
    )->css
}

@react.component(: HeaderNav.headerNavProps)
let make = (~logo, ~links) =>
  <header
    style={{
      padding: "0 58px",
      height: "68px",
      width: "100%",
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
    }}
    className={Style.wrapper}>
    <div
      style={{
        display: "flex",
        justifyContent: "space-between",
        alignItems: "center",
        width: "100%",
        height: "25px",
      }}
      className={Style.containt}>
      <HeaderNav logo links />
    </div>
  </header>
