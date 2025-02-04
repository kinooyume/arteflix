open Emotion
open ReactAria

module Style = {
  let container = ReactDOM.Style.make(~position="relative", ())->css

  // en fait ca va dependre d'horizontal ou vertical
  let previewWrapper = ReactDOM.Style.make(~position="relative", ~zIndex="80", ())->css

  let dialog = ReactDOM.Style.make(~outline="none !important", ())->css
}

type t = (MovieCardImage.props, MoviePreview.props)

type movieCardProps = {
  key?: string,
  linkAlt?: option<LinkAlt.make>,
  cardProps: MovieCardImage.props,
  previewProps: MoviePreview.props,
  children?: React.element,
}

module LazyPreview = {
  let make = React.lazy_(() => import(MoviePreview.make))
}

@react.component(: movieCardProps)
let make = (~cardProps, ~previewProps, ~linkAlt=None, ~children=React.null) => {
  let triggerRef = React.useRef(Nullable.null)

  let (cardHovered, setCardHovered) = React.useState(() => false)
  let (previewHovered, setPreviewHovered) = React.useState(() => false)

  let (isOpen, setIsOpen) = React.useState(() => false)

  let card = Hooks.useHover({
    onHoverStart: _ => {
      setCardHovered(_ => true)
    },
    onHoverEnd: _ => {
      setCardHovered(_ => false)
    },
  })

  let preview = Hooks.useHover({
    onHoverStart: _ => {
      setPreviewHovered(_ => true)
    },
    onHoverEnd: _ => {
      setPreviewHovered(_ => false)
    },
  })

  let isVisible = cardHovered || previewHovered
  React.useEffect(() => {
    if cardHovered {
      let timeOutId = setTimeout(_ => setIsOpen(_ => true), 300)
      Some(() => clearTimeout(timeOutId))
    } else {
      // if isOpen {
      //   setIsOpen(_ => false)
      // }
      None
    }
  }, [cardHovered])

  <div key={cardProps.id}>
    <div {...card.hoverProps} ref={ReactDOM.Ref.domRef(triggerRef)}>
      <MovieCardImage {...cardProps}> {children} </MovieCardImage>
    </div>
    <Popover isOpen triggerRef placement=#top offset={-246}>
      <Dialog ariaLabel={cardProps.title} className={Style.dialog} ariaLabelledBy="MovieCard">
        <div {...preview.hoverProps} className={Style.previewWrapper}>
          <MoviePreview
            {...previewProps} isVisible onExit={_ => setIsOpen(_ => false)}
          />
        </div>
      </Dialog>
    </Popover>
  </div>
}
