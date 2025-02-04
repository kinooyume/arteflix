open Emotion

let style =
  ReactDOM.Style.make(
    ~display="flex",
    ~alignItems="flex-start",
    ~flexWrap="wrap",
    ~gap="20px",
    (),
  )->css

type movieCardSliderProps = {children: array<React.element>}

@react.component(: movieCardSliderProps)
let make = (~children) => {
  <div className={style}> {children->React.array} </div>
}
