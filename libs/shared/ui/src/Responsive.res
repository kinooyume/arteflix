let mobile = 600
let tablet = 1024
let desktop = 1440

let mobileDown = `@media (max-width: 599px)`
let tabletDown = `@media (max-width: 1023px)`
let touchDevice = `@media (hover: none)`

@val external matchMedia: string => {"matches": bool} = "window.matchMedia"

let useTouchDevice = () => {
  let (isTouch, setIsTouch) = React.useState(() => false)
  React.useEffect(() => {
    setIsTouch(_ => matchMedia("(hover: none)")["matches"])
    None
  }, [])
  isTouch
}
