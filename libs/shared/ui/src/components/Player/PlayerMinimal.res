open Webapi.Dom
open Emotion

%%raw("import 'video.js/dist/video-js.css'")

module Style = {
  let wrapper =
    ReactDOM.Style.make(~width="100%", ~height="100%", ~borderRadius="4px", ())->css
}

type videoProps = {
  url: string,
  onLoaded?: unit => unit,
  options: VideoJs.playerOptions,
}

@react.component(: videoProps)
let make = (~url, ~onLoaded=?, ~options) => {
  let videoRef = React.useRef(Js.Nullable.null)
  let playerRef = React.useRef(Js.Nullable.null)

  React.useEffect(() => {
    switch playerRef.current {
    | Value(video) => {
        switch options.autoplay {
        | Some(autoplay) => video->VideoJs.autoplay(~autoplay)
        | None => ()
        }
        let _ = video->VideoJs.src(url)
        None
      }
    | _ =>
      switch videoRef.current {
      | Value(ref) => {
          let videoElement = document->Document.createElement("video-js")
          let class =
            " video-js vjs-big-play-centered vjs-fill " ++ " " ++ Typo.Regular.headline2Force

          videoElement->Element.setClassName(class)

          ref->Element.appendChild(~child=videoElement)
          playerRef.current = Value(videoElement)
          let opts = {...options, controls: false, loop: true, autoplay: #muted}
          let video = VideoJs.videojs(~id=#Element(videoElement), ~options=opts)
          playerRef.current = Value(video)
          // switch options.autoplay {
          // | Some(autoplay) => video->VideoJs.autoplay(~autoplay)
          // | None => ()
          // }
          video->VideoJs.ready(~fn=() => {
            let _ = VideoJs.src(video, url)
            switch onLoaded {
            | Some(cb) => video->VideoJs.on(~event="canplay", ~fn=cb)
            | None => ()
            }
          }, ~sync=true)
          None
        }
      | _ => None
      }
    }
  }, [videoRef])

  //   // Js.Json.strin
  //   // Colors->Dict.o
  //   //
  //
  // external recordAsJson: 'a => Js.Dict.t<Js.Json.t> = "%identity"
  //
  // let json = params2->recordAsJson→Js.Json.object_

  React.useEffect(() => {
    Some(
      () => {
        switch playerRef.current {
        | Value(video) =>
          if !(video->VideoJs.isDisposed) {
            let _ = video->VideoJs.dispose()
            let _ = playerRef.current = Js.Nullable.null
          }
        | _ => ()
        }
      },
    )
  }, [playerRef])

  <div className={Style.wrapper}>
    <div
      className={" video-js vjs-fill " ++ Typo.Regular.headline2Force}
      ref={ReactDOM.Ref.domRef(videoRef)}
    />
  </div>
}
