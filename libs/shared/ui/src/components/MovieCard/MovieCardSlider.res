open Emotion
open ReactSlick

%%raw("
import 'slick-carousel/slick/slick.css';
import 'slick-carousel/slick/slick-theme.css';
")

let slideGap = `padding: 0 4px;`->rawCss

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
    margin: 0 -4px;
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

  ${Responsive.mobileDown} {
    .slick-prev, .slick-next {
      display: none !important;
    }
  }
  `->rawCss

let responsive = [
  {
    breakpoint: 600,
    settings: {
      slidesToShow: 2,
      slidesToScroll: 2,
    },
  },
  {
    breakpoint: 900,
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
    breakpoint: 1400,
    settings: {
      slidesToShow: 5,
      slidesToScroll: 5,
    },
  },
  {
    breakpoint: 2200,
    settings: {
      slidesToShow: 6,
      slidesToScroll: 6,
    },
  },
  {
    breakpoint: 3100,
    settings: {
      slidesToShow: 8,
      slidesToScroll: 8,
    },
  },
]

type movieCardSliderProps = {children: array<React.element>}

@react.component(: movieCardSliderProps)
let make = (~children) => {
  let isTouch = Responsive.useTouchDevice()
  let slickProps = {
    dots: false,
    infinite: false,
    speed: 500,
    slidesToShow: 10,
    slidesToScroll: 10,
    draggable: isTouch,
    initialSlide: 0,
    swipeToSlide: isTouch,
    touchThreshold: 15,
    variableWidth: false,
    responsive,
  }
  <div className={Style.container}>
    <ReactSlick {...slickProps} className={slickStyle}>
      {children
      ->Array.mapWithIndex((slide, index) =>
        <div key={index->Int.toString} className={slideGap}> slide </div>
      )
      ->React.array}
    </ReactSlick>
  </div>
}
