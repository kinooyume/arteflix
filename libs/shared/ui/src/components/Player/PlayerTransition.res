open Emotion

module Style = {
  let container = `
    position: relative;
    width: 100%;
    height: 100%;
    isolation: isolate;
  `->rawCss

  let video = `
    position: absolute;
    inset: 0;
    & .vjs-tech {
      object-fit: cover;
    }
  `->rawCss

  let cover = (~visible) =>
    `
    position: absolute;
    inset: 0;
    z-index: 1;
    opacity: ${visible ? "1" : "0"};
    transition: opacity 400ms ease;
  `->rawCss
}

type url = Url(string) | ToFetch(unit => promise<string>) | NoVideo

type props_ = {
  urlOption: url,
  delay?: int,
  muted?: bool,
  loop?: bool,
  onPlayingChange?: bool => unit,
  children: React.element,
}

@react.component(: props_)
let make = (~urlOption, ~delay=0, ~muted=true, ~loop=true, ~onPlayingChange=?, ~children) => {
  let (videoUrl, setVideoUrl) = React.useState(() => None)
  let (playing, setPlaying) = React.useState(() => false)

  React.useEffect0(() => {
    let cancelled = ref(false)
    let resolve = url =>
      if !cancelled.contents {
        setVideoUrl(_ => Some(url))
      }
    let timer = setTimeout(() =>
      switch urlOption {
      | NoVideo => ()
      | Url(url) => resolve(url)
      | ToFetch(fetch) =>
        fetch()
        ->Promise.thenResolve(resolve)
        ->Promise.catch(_ => Promise.resolve())
        ->ignore
      }
    , delay)
    Some(
      () => {
        cancelled := true
        clearTimeout(timer)
      },
    )
  })

  React.useEffect(() => {
    onPlayingChange->Option.forEach(f => f(playing))
    None
  }, [playing])

  let stop = () => {
    setPlaying(_ => false)
    setVideoUrl(_ => None)
  }

  <div className={Style.container}>
    {switch videoUrl {
    | Some(url) =>
      <div className={Style.video}>
        <PlayerMinimal
          url
          muted
          loop
          options={{preload: #auto, fluid: false}}
          onLoaded={() => setPlaying(_ => true)}
          onError=stop
          onEnded=stop
        />
      </div>
    | None => React.null
    }}
    <div className={Style.cover(~visible=!playing)}> children </div>
  </div>
}
