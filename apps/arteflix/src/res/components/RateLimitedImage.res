@react.component
let make = (~src, ~alt, ~className=?, ~onLoad=?, ~width, ~height, ~sizes, ~priority=false, ~loading=?) => {
  let (rateSrc, onRateLoad, onRateError) = UseRateLimitedSrc.use(~src)

  let handleLoad = _event => {
    onRateLoad()
    switch onLoad {
    | Some(f) => f()
    | None => ()
    }
  }

  switch rateSrc {
  | Some(src) =>
    <Next.Image
      src
      alt
      ?className
      onLoad={handleLoad}
      onError={_ => onRateError()}
      width
      height
      sizes
      priority
      ?loading
    />
  | None => <div ?className />
  }
}
