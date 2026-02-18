open Emotion
open ReactSlick

%%raw("
import 'slick-carousel/slick/slick.css';
import 'slick-carousel/slick/slick-theme.css';
")

let style = ReactDOM.Style.make(~paddingRight="6px", ())->css

module Style = {
  let container = ReactDOM.Style.make(~width="100%", ())->css
}

let slickStyle = `
  width: 100%;

  .slick-track {
  display: flex;
    margin-left: 0;
  }
  .slick-list {
    width: 100%;
  }
  .slick-prev.slick-disabled, .slick-next.slick-disabled {
    display: none !important;
  }
  .slick-prev, .slick-next {
    z-index: 30;
    top: 0;
    height: 100%;
    width: 36px;
    transform: none;
    background-color: ${Colors.transparentBlack_30};
  }

  .slick-prev:before, .slick-next:before {
    font-size: 28px;
    color: ${Colors.greyGrey_10};
  }

  .slick-prev:hover , .slick-next:hover {
    background-color: ${Colors.transparentBlack_60};
  }
  .slick-prev {
    left: 0;
  }
  .slick-next {
  right: 0;
  }
  `->rawCss

let responsive = [
  {
    breakpoint: 500,
    settings: {
      slidesToShow: 2,
      slidesToScroll: 2,
    },
  },
  {
    breakpoint: 800,
    settings: {
      slidesToShow: 3,
      slidesToScroll: 3,
    },
  },
  {
    breakpoint: 1100,
    settings: {
      slidesToShow: 4,
      slidesToScroll: 4,
    },
  },
  {
    breakpoint: 1500,
    settings: {
      slidesToShow: 6,
      slidesToScroll: 6,
    },
  },
  {
    breakpoint: 2200,
    settings: {
      slidesToShow: 9,
      slidesToScroll: 9,
    },
  },
  {
    breakpoint: 3100,
    settings: {
      slidesToShow: 13,
      slidesToScroll: 13,
    },
  },
]

let slickProps = {
  dots: false,
  infinite: false,
  speed: 500,
  slidesToShow: 4,
  slidesToScroll: 4,
  draggable: false,
  initialSlide: 0,
  swipeToSlide: false,
  variableWidth: false,
  responsive,
}
type movieCardSliderProps = {children: array<React.element>}

@react.component(: movieCardSliderProps)
let make = (~children) => {
  <div className={Style.container}>
    <ReactSlick {...slickProps} className={slickStyle}>
      {children
      ->Array.mapWithIndex((slide, index) =>
        <div key={index->Int.toString} className={style}> slide </div>
      )
      ->React.array}
    </ReactSlick>
  </div>
}
