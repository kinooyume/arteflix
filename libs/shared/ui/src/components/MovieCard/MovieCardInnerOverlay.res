open Emotion

let style =
  ReactDOM.Style.make(
    ~display="flex",
    ~justifyContent="center",
    ~alignItems="flex-end",
    ~position="absolute",
    ~top="0",
    ~bottom="0",
    ~left="0",
    ~right="0",
    (),
  )->css


@react.component
let make = (~children) => {
  <div className={style}> {children} </div>
}
