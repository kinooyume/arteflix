open Emotion

type item = {title: string, href: string}

module Style = {
  let row = `
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    width: 100%;
  `->rawCss

  let pill = `
    display: inline-flex;
    align-items: center;
    padding: 8px 16px;
    border: 1px solid ${Colors.greyGrey_400};
    border-radius: ${Radius.full};
    color: ${Colors.greyGrey_10};
    text-decoration: none;
    white-space: nowrap;
    transition: border-color 0.2s, color 0.2s;

    &:hover {
      border-color: ${Colors.primaryWhite};
      color: ${Colors.primaryWhite};
    }
  `->rawCss
}

type props_ = {
  title: option<string>,
  items: array<item>,
}

@react.component(: props_)
let make = (~title, ~items) => {
  <MovieBlock title>
    <div className={Style.row}>
      {items->Array.mapWithIndex((item, i) =>
        <a
          key={Int.toString(i)}
          href={item.href}
          className={cx([Style.pill, Typo.Regular.smallBody])}>
          {item.title->React.string}
        </a>
      )->React.array}
    </div>
  </MovieBlock>
}
