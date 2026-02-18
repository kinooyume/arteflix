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

  let row = `
    padding: 0 var(--side-padding);
    margin-bottom: 32px;
    display: flex;
    flex-direction: column;
    gap: 12px;
  `->rawCss

  let cards = `
    display: flex;
    gap: 8px;
    overflow: hidden;
  `->rawCss

  let titleBar = `
    width: 180px;
  `->rawCss
}

let cardRow = index =>
  <div key={index->Int.toString} className={Style.row}>
    <div className={Style.titleBar}>
      <Shimmer width="180px" height="20px" />
    </div>
    <div className={Style.cards}>
      {Array.fromInitializer(~length=6, i =>
        <Shimmer key={i->Int.toString} width="325px" height="183px" borderRadius="2px" />
      )->React.array}
    </div>
  </div>

@react.component
let make = () =>
  <div className={Style.container}>
    <div className={Style.hero}>
      <Shimmer width="100%" height="clamp(300px, 56vw, 720px)" borderRadius="0px" />
    </div>
    {Array.fromInitializer(~length=3, cardRow)->React.array}
  </div>
