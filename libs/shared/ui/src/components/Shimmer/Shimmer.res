open Emotion

let shimmerAnimation = keyframes({
  "0%": rawCss("background-position: -400px 0"),
  "100%": rawCss("background-position: 400px 0"),
})

module Style = {
  let base = (~width, ~height, ~borderRadius) =>
    `
    width: ${width};
    height: ${height};
    border-radius: ${borderRadius};
    background: ${Colors.greyGrey_800};
    background-image: linear-gradient(
      90deg,
      ${Colors.greyGrey_800} 0px,
      ${Colors.greyGrey_700} 200px,
      ${Colors.greyGrey_800} 400px
    );
    background-size: 800px 100%;
    background-repeat: no-repeat;
    animation: ${shimmerAnimation} 1.6s ease-in-out infinite;
  `->rawCss
}

type props_ = {
  width: string,
  height: string,
  borderRadius?: string,
  className?: string,
}

@react.component(: props_)
let make = (~width, ~height, ~borderRadius="4px", ~className=?) =>
  <div
    className={switch className {
    | Some(extra) => cx([Style.base(~width, ~height, ~borderRadius), extra])
    | None => Style.base(~width, ~height, ~borderRadius)
    }}
  />
