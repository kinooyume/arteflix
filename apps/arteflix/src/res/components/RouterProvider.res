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
  let pathname = Location.usePath()->Option.getOr("")
  let (transition, setTransition) = React.useState(() => {isLeaving: false, zoomIn: false})
  let timerRef = React.useRef(Nullable.null)

  React.useEffect(() => {
    setTransition(_ => {isLeaving: false, zoomIn: false})
    None
  }, [pathname])

  let navigateRef = React.useRef(ignore)
  navigateRef.current = href => {
    if href !== pathname {
      switch timerRef.current->Nullable.toOption {
      | Some(id) => clearTimeout(id)
      | None => ()
      }
      let isVideoPage = pathname->String.includes("/videos/")
      setTransition(_ => {isLeaving: true, zoomIn: isVideoPage})
      timerRef.current = Nullable.make(
        setTimeout(() => {
          Location.push(href)
        }, 200),
      )
    }
  }
  let navigate = React.useMemo0(() => href => navigateRef.current(href))

  <TransitionProvider value=transition>
    <RouterProvider navigate> children </RouterProvider>
  </TransitionProvider>
}
