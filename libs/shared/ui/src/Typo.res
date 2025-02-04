open Emotion

//TODO: ça doit etre des components du coup !
// On alors on en fait
// <==> Equivalent en component

// NOTE: en --Primary-White, du coup pas de culeur
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
  let headline2 =
    ReactDOM.Style.make(
      ~color="white",
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
      ~fontSize="17px",
      ~fontStyle="normal",
      ~fontWeight="400",
      ~lineHeight="normal",
      ~textShadow="2px 2px 4px rgba(0,0,0,.45)",
      (),
    )->css

  let subtitle =
    ReactDOM.Style.make(
      ~fontFamily="Netflix Sans",
      ~fontSize="20.856px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="normal",
      ~letterSpacing="-0.435px",
      (),
    )->css

  let caption2 =
    ReactDOM.Style.make(
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
      ~fontSize="11px",
      ~fontStyle="normal",
      ~fontWeight="400",
      ~lineHeight="normal",
      (),
    )->css
  let title1 =
    ReactDOM.Style.make(
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
      ~fontSize="27px",
      ~fontStyle="normal",
      ~fontWeight="400",
      ~lineHeight="36px",
      ~margin="16px 0",
      ~color="#FFF",
      ~textShadow="2px 2px 4px rgba(0,0,0,.45)",
      (),
    )->css

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
  let headline2 =
    ReactDOM.Style.make(
      ~color="var(--Grey-Grey-10, #E5E5E5)",
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
      ~fontSize="20px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="18px",
      (),
    )->css
  let title3 =
    ReactDOM.Style.make(
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
      ~fontSize="24px",
      ~fontStyle="normal",
      ~fontWeight="500",
      ~lineHeight="normal",
      (),
    )->css
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
  let title1 =
    ReactDOM.Style.make(
      ~fontFamily="Netflix Sans, Tahoma, Verdana, sans-serif",
      ~fontSize="48px",
      ~fontStyle="normal",
      ~fontWeight="700",
      ~lineHeight="48px",
      ~margin="0",
      ~textShadow="2px 2px 4px rgba(0,0,0,.45)",
      (),
    )->css

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
