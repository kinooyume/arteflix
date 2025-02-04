open Emotion

let style =
  ReactDOM.Style.make(
    ~display="flex",
    // ~width="323px",
    // ~height="403px",
    ~width="100%",
    ~height="100%",
    ~flexDirection="column",
    ~justifyContent="flex-start",
    ~alignItems="flex-start",
    ~flexShrink="0",
    ~overflow="hidden",
    ~borderRadius="4px",
    ~boxShadow="0px 0px 20px 0px rgba(0, 0, 0, 0.50)",
    ~backgroundColor=Colors.greyGrey_900,
    (),
  )->css

type previewProps = {key?: string, children: React.element}

@react.component(: previewProps)
let make = ( ~children) => <div className={style}> {children} </div>
