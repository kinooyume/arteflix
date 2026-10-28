@@directive("'use client';")
open ReactAriaProvider

type contextValue = {isLeaving: bool, zoomIn: bool}
let context = React.createContext({isLeaving: false, zoomIn: false})
let useTransition = () => React.useContext(context)

module TransitionProvider = {
  let make = React.Context.provider(context)
}

@react.component
let make = (~children) => {
  let location = Location.useLocation()
  let pathname = location->Option.map(l => l.path)->Option.getOr("")
  let (transition, setTransition) = React.useState(() => {isLeaving: false, zoomIn: false})
  let timerRef = React.useRef(Nullable.null)

  React.useEffect(() => {
    setTransition(_ => {isLeaving: false, zoomIn: false})
    None
  }, [pathname])

  let navigateRef = React.useRef((_, _) => ())
  navigateRef.current = (href, options) => {
    let play = options->Option.flatMap(o => o.ReactAria.play)->Option.getOr(false)
    let opensModal = switch href->Routes.pathOf->Routes.parse {
    | Video({id}) => Routes.isCollection(id) && !play
    | _ => false
    }
    if opensModal {
      let background = location->Option.flatMap(l => l.background)->Option.getOr(pathname)
      Location.push(href, ~background)
    } else if href !== pathname || play {
      switch timerRef.current->Nullable.toOption {
      | Some(id) => clearTimeout(id)
      | None => ()
      }
      let isVideoPage = pathname->String.includes("/videos/")
      setTransition(_ => {isLeaving: true, zoomIn: isVideoPage})
      timerRef.current = Nullable.make(
        setTimeout(() => {
          Location.push(href, ~play)
        }, 200),
      )
    }
  }
  let navigate = React.useMemo0(() => (href, options) => navigateRef.current(href, options))

  <TransitionProvider value=transition>
    <RouterProvider navigate> children </RouterProvider>
  </TransitionProvider>
}
