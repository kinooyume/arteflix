open Emotion

let fontFamily = "Netflix Sans, Helvetica Neue, Helvetica, Arial, sans-serif"

module Regular = {
  let caption2 =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="11px",
      ~fontStyle="normal",
      ~fontWeight="400",
      ~lineHeight="1.277em",
      (),
    )->css

  let caption1 =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="13px",
      ~fontStyle="normal",
      ~fontWeight="400",
      ~lineHeight="1.231em",
      ~letterSpacing="1.92%",
      (),
    )->css

  let smallBody =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="14px",
      ~fontStyle="normal",
      ~margin="0",
      ~fontWeight="400",
      ~lineHeight="1.429em",
      (),
    )->css

  let body =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="16px",
      ~fontStyle="normal",
      ~margin="0",
      ~fontWeight="400",
      ~lineHeight="1.277em",
      (),
    )->css

  let headline2Force =
    ReactDOM.Style.make(
      ~color="white !important",
      ~fontFamily=fontFamily ++ " !important",
      ~fontSize="17px !important",
      ~fontStyle="normal !important",
      ~fontWeight="400 !important",
      ~lineHeight="normal !important",
      ~textShadow="2px 2px 4px rgba(0,0,0,.45)",
      (),
    )->css

  let headline2 = `
    color: white;
    font-family: ${fontFamily};
    font-size: clamp(13px, 0.65rem + 0.35vw, 17px);
    font-style: normal;
    font-weight: 400;
    line-height: 1.277em;
    text-shadow: 2px 2px 4px rgba(0,0,0,.45);
  `->rawCss

  let headline1 =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="18px",
      ~fontStyle="normal",
      ~fontWeight="400",
      ~lineHeight="1.222em",
      (),
    )->css

  let subtitle = `
    font-family: Netflix Sans;
    font-size: clamp(16px, 0.8rem + 0.6vw, 21px);
    font-style: normal;
    font-weight: 500;
    line-height: normal;
    letter-spacing: -0.435px;
  `->rawCss

  let title4 =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="20px",
      ~fontStyle="normal",
      ~fontWeight="400",
      ~lineHeight="1.5em",
      (),
    )->css

  let title3 =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="21px",
      ~fontStyle="normal",
      ~fontWeight="400",
      ~lineHeight="1.19em",
      (),
    )->css

  let title2 =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="24px",
      ~fontStyle="normal",
      ~fontWeight="400",
      ~lineHeight="1.25em",
      (),
    )->css

  let title1 = `
    font-family: ${fontFamily};
    font-size: clamp(16px, 0.8rem + 0.7vw, 27px);
    font-style: normal;
    font-weight: 400;
    line-height: 1.333em;
    margin: 16px 0;
    color: #FFF;
    text-shadow: 2px 2px 4px rgba(0,0,0,.45);
  `->rawCss

  let largeTitle =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="50px",
      ~fontStyle="normal",
      ~fontWeight="400",
      ~lineHeight="1.277em",
      (),
    )->css
}

module Medium = {
  let caption =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="10px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="normal",
      (),
    )->css

  let caption2 =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="12px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="1.277em",
      ~letterSpacing="-2.08%",
      (),
    )->css

  let caption1 =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="13px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="1.277em",
      (),
    )->css

  let smallBody =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="14px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="1.277em",
      (),
    )->css

  let trailer =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="16px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="20px",
      (),
    )->css

  let description =
    ReactDOM.Style.make(
      ~fontFamily="Netflix Sans",
      ~fontSize="16px",
      ~fontStyle="normal",
      ~fontWeight="400",
      ~lineHeight="26px",
      (),
    )->css

  let body =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="16px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="1.5em",
      (),
    )->css

  let bodyLW = cx([body, ReactDOM.Style.make(~letterSpacing="0.5px", ())->css])

  let headline2 = `
    color: var(--Grey-Grey-10, #E5E5E5);
    font-family: ${fontFamily};
    font-size: clamp(16px, 0.8rem + 0.5vw, 20px);
    font-style: normal;
    font-weight: 500;
    line-height: 1.5em;
  `->rawCss

  let headline1 =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="21px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="1.19em",
      (),
    )->css

  let title4 =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="22px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="1em",
      (),
    )->css

  let title3 = `
    font-family: ${fontFamily};
    font-size: clamp(18px, 0.9rem + 0.75vw, 24px);
    font-style: normal;
    font-weight: 500;
    line-height: 1.277em;
  `->rawCss

  let title3LW = cx([title3, ReactDOM.Style.make(~letterSpacing="-2.08%", ())->css])

  let title2 =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="28px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="1.607em",
      (),
    )->css

  let title1 =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="30px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="1.5em",
      (),
    )->css

  let largeTitle =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="33px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="1.277em",
      (),
    )->css
}

module Bold = {
  let title2 =
    ReactDOM.Style.make(
      ~fontFamily,
      ~fontSize="20px",
      ~fontStyle="normal",
      ~fontWeight="700",
      ~lineHeight="1.5em",
      ~color="#FFF",
      (),
    )->css

  let title1 = `
    font-family: ${fontFamily};
    font-size: clamp(22px, 1rem + 2vw, 48px);
    font-style: normal;
    font-weight: 700;
    line-height: 1.292em;
    margin: 0;
    text-shadow: 2px 2px 4px rgba(0,0,0,.45);
  `->rawCss

  let largeTitle = `
    font-family: ${fontFamily};
    font-size: 55px;
    font-style: normal;
    font-weight: 700;
    line-height: 1.277em;
    letter-spacing: -1.82%;
  `->rawCss
}
