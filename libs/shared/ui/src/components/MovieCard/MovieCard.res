open Emotion
open ReactAria

@get external offsetWidth: Dom.element => float = "offsetWidth"

module Style = {
  let container = ReactDOM.Style.make(~position="relative", ())->css

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
  let isTouch = Responsive.useTouchDevice()

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
      None
    }
  }, [cardHovered])

  let cardWidth = switch triggerRef.current->Nullable.toOption {
  | Some(el) => el->offsetWidth
  | None => 218.0
  }
  let popoverOffset = Float.toInt(cardWidth *. 9.0 /. 16.0 *. -2.0)

  <div key={cardProps.id}>
    <div {...card.hoverProps} ref={ReactDOM.Ref.domRef(triggerRef)}>
      <MovieCardImage {...cardProps}> {children} </MovieCardImage>
    </div>
    {switch isTouch {
    | true => React.null
    | false =>
      <Popover isOpen triggerRef placement=#top offset=popoverOffset>
        <Dialog ariaLabel={cardProps.title} className={Style.dialog} ariaLabelledBy="MovieCard">
          <div {...preview.hoverProps} className={Style.previewWrapper}>
            <MoviePreview
              {...previewProps} isVisible cardWidth onExit={_ => setIsOpen(_ => false)}
            />
          </div>
        </Dialog>
      </Popover>
    }}
  </div>
}
