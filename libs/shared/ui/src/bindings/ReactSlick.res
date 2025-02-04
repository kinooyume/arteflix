type settings = {
  dots?: bool,
  infinite?: bool,
  slidesToShow: int,
  slidesToScroll: int,
  initialSlide?: int,
}

type responsive = {breakpoint: int, settings: settings}

@untagged
type lazyload = [#ondemand | #progressive]

type sliderProps = {
  dots?: bool,
  infinite?: bool,
  speed?: int,
  centerMode?: bool,
  lazyLoad?: lazyload,
  slidesToShow?: int,
  slidesToScroll?: int,
  initialSlide?: int,
  responsive?: array<responsive>,
  swipeToSlide?: bool,
  draggable?: bool,
  variableWidth?: bool,
  children?: React.element,
  className?: string,
}
@module("react-slick") @react.component(: sliderProps)
external make: sliderProps => React.element = "default"
