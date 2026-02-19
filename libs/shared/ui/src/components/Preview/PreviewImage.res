open Emotion
open ReactAria

let style = imagePath =>
  ReactDOM.Style.make(
    ~display="flex",
    ~maxWidth="323px",
    ~maxHeight="181px",
    ~width="100%",
    ~height="100%",
    ~minHeight="123px",
    // ~padding="133px 20px 8px 263px",
    ~justifyContent="flex-end",
    ~alignItems="center",
    ~flexShrink="0",
    ~backgroundImage=`url(${imagePath})`,
    ~backgroundColor="lightgray",
    ~backgroundSize="cover",
    ~backgroundPosition="50%",
    ~backgroundRepeat="no-repeat",
    ~borderRadius="4px 4px 0 0",
    ~outline="none",
    (),
  )->css

type previewImageProps = {
  srcBase: string,
  href: string,
}

// NOTE: du coup ça peut etre preview card image. hehehehe
@react.component(: previewImageProps)
let make = (~srcBase, ~href) => {
  let src = srcBase->String.replace("__SIZE__", "380x214")
  <Link href>
    <div className={style(src)} />
  </Link>
}
