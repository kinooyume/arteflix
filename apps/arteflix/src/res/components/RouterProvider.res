@@directive("'use client';")
open ReactAriaProvider

type contextValue = {isLeaving: bool, zoomIn: bool}
let context = React.createContext({isLeaving: false, zoomIn: false})
let useTransition = () => React.useContext(context)

module TransitionProvider = {
  let make = React.Context.provider(context)
}

let setupHoverPrefetch: Next.Navigation.router => unit => unit = %raw(`
  function(router) {
    var timer;
    function onOver(e) {
      var a = e.target.closest('a[href]');
      if (!a || a.closest('[role="dialog"]')) return;
      var href = a.getAttribute('href');
      if (!href || /^https?:/.test(href) || href[0] === '#') return;
      clearTimeout(timer);
      timer = setTimeout(function() { router.prefetch(href); }, 150);
    }
    function onOut() { clearTimeout(timer); }
    document.addEventListener('mouseover', onOver);
    document.addEventListener('mouseout', onOut);
    return function() {
      document.removeEventListener('mouseover', onOver);
      document.removeEventListener('mouseout', onOut);
    };
  }
`)

@react.component
let make = (~children) => {
  let router = Next.Navigation.useRouter()
  let pathname = Next.Navigation.usePathname()
  let (transition, setTransition) = React.useState(() => {isLeaving: false, zoomIn: false})
  let timerRef = React.useRef(Nullable.null)

  React.useEffect(() => {
    setTransition(_ => {isLeaving: false, zoomIn: false})
    None
  }, [pathname])

  React.useEffect0(() => {
    let cleanup = setupHoverPrefetch(router)
    Some(cleanup)
  })

  let navigateRef = React.useRef(ignore)
  navigateRef.current = href => {
    if href !== pathname {
      switch timerRef.current->Nullable.toOption {
      | Some(id) => clearTimeout(id)
      | None => ()
      }
      let isVideoPage = pathname->String.includes("/videos/")
      router.prefetch(~href)
      setTransition(_ => {isLeaving: true, zoomIn: isVideoPage})
      timerRef.current = Nullable.make(
        setTimeout(() => {
          router.push(href)
        }, 200),
      )
    }
  }
  let navigate = React.useMemo0(() => href => navigateRef.current(href))

  <TransitionProvider value=transition>
    <RouterProvider navigate> children </RouterProvider>
  </TransitionProvider>
}
