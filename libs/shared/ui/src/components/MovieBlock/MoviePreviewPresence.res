open FramerMotion

module Container = {
  type props_ = {onExit?: unit => unit}
  @react.component(: props_)
  let make = (~onExit=() => ()) => {
    let (isPresent, safeToRemove) = Hooks.usePresence()

    React.useEffect(() => {
      switch isPresent {
      | false => {
          let timeoutId = setTimeout(() => {
            safeToRemove()
            onExit()
          }, 100)
          Some(() => clearTimeout(timeoutId))
        }
      | true => None
      }
    }, [isPresent])

    <div />
  }
}

type props_ = {
  isVisible?: bool,
  children: React.element,
}

@react.component(: props_)
let make = (~isVisible=false, ~children) => {
  <AnimatePresence>
    {switch isVisible {
    | true => children
    | false => React.null
    }}
  </AnimatePresence>
}
