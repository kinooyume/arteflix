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
    top: 61px;
    height: 123px;
    width: 36px;
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

// mes images, 218px + 6px = 224px
// padding: 46px

let responsive = [
  {
    breakpoint: 524,
    settings: {
      slidesToShow: 1,
      slidesToScroll: 1,
    },
  },
  {
    breakpoint: 788,
    settings: {
      slidesToShow: 2,
      slidesToScroll: 2,
    },
  },
  {
    breakpoint: 982,
    settings: {
      slidesToShow: 3,
      slidesToScroll: 3,
    },
  },
  {
    breakpoint: 1146,
    settings: {
      slidesToShow: 4,
      slidesToScroll: 4,
    },
  },
  {
    breakpoint: 1360,
    settings: {
      slidesToShow: 5,
      slidesToScroll: 5,
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
    breakpoint: 1700,
    settings: {
      slidesToShow: 7,
      slidesToScroll: 7,
    },
  },
  {
    breakpoint: 1900,
    settings: {
      slidesToShow: 8,
      slidesToScroll: 8,
    },
  },
  {
    breakpoint: 2400,
    settings: {
      slidesToShow: 9,
      slidesToScroll: 9,
    },
  },
  {
    breakpoint: 2450,
    settings: {
      slidesToShow: 10,
      slidesToScroll: 10,
    },
  },
  {
    breakpoint: 2600,
    settings: {
      slidesToShow: 11,
      slidesToScroll: 11,
    },
  },
  {
    breakpoint: 2800,
    settings: {
      slidesToShow: 12,
      slidesToScroll: 12,
    },
  },
  {
    breakpoint: 2900,
    settings: {
      slidesToShow: 13,
      slidesToScroll: 13,
    },
  },
  {
    breakpoint: 3100,
    settings: {
      slidesToShow: 14,
      slidesToScroll: 14,
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
  variableWidth: true,
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
  // <div className={style}> {children->React.array} </div>
}
