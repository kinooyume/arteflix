open Emotion

module Style = {
  let container =
    ReactDOM.Style.make(
      ~display="flex",
      ~flexDirection="column",
      ~padding="20px 0px var(--section-gap) var(--side-padding)",
      ~alignItems="flex-start",
      ~gap="15px",
      ~zIndex="2",
      (),
    )->css

  let header = `
    display: flex;
    align-items: baseline;
    gap: 8px;
    &:hover .see-all {
      opacity: 1;
      transform: translateX(0);
    }
  `->rawCss

  let seeAll = `
    display: flex;
    align-items: center;
    gap: 4px;
    font-size: clamp(11px, 0.55rem + 0.3vw, 14px);
    color: ${Colors.greyGrey_10};
    text-decoration: none;
    opacity: 0;
    transform: translateX(-8px);
    transition: opacity 0.3s, transform 0.3s;
  `->rawCss

  let chevron = `
    font-size: 0.8em;
    transition: transform 0.2s;
    &:hover {
      transform: translateX(2px);
    }
  `->rawCss
}

type movieHomeBlockProps = {
  title: option<string>,
  link?: option<string>,
  children: React.element,
}

open Text

@react.component(: movieHomeBlockProps)
let make = (~title, ~link=None, ~children) => {
  <div className={Style.container}>
    {switch title {
    | Some(title) =>
      <div className={Style.header}>
        <Medium.Headline2> {title->React.string} </Medium.Headline2>
        {switch link {
        | Some(href) =>
          <a href className={[Style.seeAll, "see-all"]->cx}>
            {"Tout explorer"->React.string}
            <span className={Style.chevron}> {`›`->React.string} </span>
          </a>
        | None => React.null
        }}
      </div>
    | None => <> </>
    }}
    children
  </div>
}
