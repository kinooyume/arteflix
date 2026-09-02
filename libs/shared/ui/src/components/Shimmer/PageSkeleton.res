open Emotion

module Style = {
  let container = `
    padding: 0;
    overflow: hidden;
  `->rawCss

  let hero = `
    width: 100%;
    margin-bottom: 40px;
  `->rawCss
}

@react.component
let make = () =>
  <div className={Style.container}>
    <div className={Style.hero}>
      <Shimmer width="100%" height="clamp(300px, 56vw, 720px)" borderRadius="0px" />
    </div>
    {Array.fromInitializer(~length=3, i => <RowSkeleton key={i->Int.toString} />)->React.array}
  </div>
