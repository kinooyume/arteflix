open Emotion

module Regular = {
  let headline1 =
    ReactDOM.Style.make(
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
      ~fontSize="18px",
      ~fontStyle="normal",
      ~fontWeight="400",
      ~lineHeight="22px",
      (),
    )->css
  let headline2Force =
    ReactDOM.Style.make(
      ~color="white !important",
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif !important",
      ~fontSize="17px !important",
      ~fontStyle="normal !important",
      ~fontWeight="400 !important",
      ~lineHeight="normal !important",
      ~textShadow="2px 2px 4px rgba(0,0,0,.45)",
      (),
    )->css
  let headline2 = `
    color: white;
    font-family: Netflix Sans, Tahoma, Verdana, sans-serif;
    font-size: clamp(13px, 0.65rem + 0.35vw, 17px);
    font-style: normal;
    font-weight: 400;
    line-height: normal;
    text-shadow: 2px 2px 4px rgba(0,0,0,.45);
  `->rawCss

  let subtitle = `
    font-family: Netflix Sans;
    font-size: clamp(16px, 0.8rem + 0.6vw, 21px);
    font-style: normal;
    font-weight: 500;
    line-height: normal;
    letter-spacing: -0.435px;
  `->rawCss

  let caption2 =
    ReactDOM.Style.make(
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
      ~fontSize="11px",
      ~fontStyle="normal",
      ~fontWeight="400",
      ~lineHeight="normal",
      (),
    )->css
  let title1 = `
    font-family: Netflix Sans, Tahoma, Verdana, sans-serif;
    font-size: clamp(16px, 0.8rem + 0.7vw, 27px);
    font-style: normal;
    font-weight: 400;
    line-height: 36px;
    margin: 16px 0;
    color: #FFF;
    text-shadow: 2px 2px 4px rgba(0,0,0,.45);
  `->rawCss

  let title2 =
    ReactDOM.Style.make(
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
      ~fontSize="24px",
      ~fontStyle="normal",
      ~fontWeight="400",
      ~lineHeight="30px",
      (),
    )->css

  let body =
    ReactDOM.Style.make(
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
      ~fontSize="16px",
      ~fontStyle="normal",
      ~margin="0",
      ~fontWeight="400",
      ~lineHeight="normal",
      (),
    )->css

  let smallBody =
    ReactDOM.Style.make(
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
      ~fontSize="14px",
      ~fontStyle="normal",
      ~margin="0",
      ~fontWeight="400",
      ~lineHeight="20px",
      (),
    )->css
}

module Medium = {
  let caption =
    ReactDOM.Style.make(
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
      ~fontSize="10px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="normal",
      (),
    )->css
  let headline2 = `
    color: var(--Grey-Grey-10, #E5E5E5);
    font-family: Netflix Sans, Tahoma, Verdana, sans-serif;
    font-size: clamp(16px, 0.8rem + 0.5vw, 20px);
    font-style: normal;
    font-weight: 500;
    line-height: 18px;
  `->rawCss

  let title3 = `
    font-family: Netflix Sans, Tahoma, Verdana, sans-serif;
    font-size: clamp(18px, 0.9rem + 0.75vw, 24px);
    font-style: normal;
    font-weight: 500;
    line-height: normal;
  `->rawCss

  let smallBody =
    ReactDOM.Style.make(
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
      ~fontSize="14px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="normal",
      (),
    )->css
  let trailer =
    ReactDOM.Style.make(
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
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
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
      ~fontSize="16px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="24px",
      (),
    )->css
  let bodyLW = cx([body, ReactDOM.Style.make(~letterSpacing="0.5px", ())->css])
}

module Bold = {
  let title1 = `
    font-family: Netflix Sans, Tahoma, Verdana, sans-serif;
    font-size: clamp(22px, 1rem + 2vw, 48px);
    font-style: normal;
    font-weight: 700;
    line-height: 1;
    margin: 0;
    text-shadow: 2px 2px 4px rgba(0,0,0,.45);
  `->rawCss

  let title2 =
    ReactDOM.Style.make(
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
      ~fontSize="20px",
      ~fontStyle="normal",
      ~fontWeight="700",
      ~lineHeight="30px",
      ~color="#FFF",
      (),
    )->css
}
