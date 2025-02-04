open Webapi.Dom
open Emotion

%%raw("import 'video.js/dist/video-js.css'")

module Style = {
  let wrapper =
    ReactDOM.Style.make(~width="100%", ~height="calc(100vh)", ~borderRadius="4px", ())->css

  let player = `
    color:  ${Colors.primaryWhite};

.vjs-button {
    width: 34px;
    height: 42px;
    align-items: center;
padding: 0 32px;
    }

.vjs-button > .vjs-icon-placeholder:before {
    font-size: 2.3em;
    }

.vjs-time-control {
 position: absolute !important;
  right: 0 !important;
  top: -25px !important;
    }

    .vjs-menu {
    width: 256px !important;
    border: none !important;
    bottom: -12px;
    left: -180px;
    border-radius: 4px;
    border: 1px solid transparent;
    }

    .vjs-menu .vjs-menu-content {
    background-color: ${Colors.greyGrey_750} !important;
    }
.vjs-menu .vjs-menu-content .vjs-menu-item {
display: flex !important;
padding: 15px 20px !important;
gap: 10px  !important;

    }
.vjs-menu-item.vjs-selected {
    background-color: ${Colors.greyGrey_750} !important;
color: #FFF !important;
    }
.vjs-menu .vjs-menu-content .vjs-menu-item.vjs-selected span {
color: #FFF !important;
    }
.vjs-menu .vjs-menu-content .vjs-menu-item:hover {
    background-color: ${Colors.greyGrey_750} !important;
    }

    .vjs-menu .vjs-menu-content .vjs-menu-item:hover span {
color: #FFF !important;
    }
.vjs-menu .vjs-menu-content {
justify-content: flex-start !important;
font-family: "Netflix Sans" !important ;
    }
.vjs-menu li {
    justify-content: flex-start !important;
    }
    .vjs-menu .vjs-menu-content .vjs-menu-item span {
    text-align: left !important;
color: var(--Grey-Grey-100, #B3B3B3) !important;
font-family: "Netflix Sans" !important ;
font-size: 14px !important ;
font-style: normal !important ;
font-weight: 400 !important;
line-height: 16px !important;
    }

.vjs-fullscreen-control  {
    }
 .vjs-audio-button {
    }
.vjs-subs-caps-button  {
    }
    .vjs-play-control, .vjs-volume-panel, .vjs-remaining-time {
    }

    .vjs-volume-panel  {
    margin-right: auto !important;
    }
    .vjs-volume-control {
    padding-top: 6px !important;
    }
    .vjs-control-bar {
      background-color: ${Colors.primaryBlack} !important;
      background-color: transparent !important;
      height: 92px !important;
    padding: 16px 20px !important;
    }

    .vjs-progress-control {
      height: 6px !important;
      position: absolute !important;
      top: 0;
      left: 0;
      right: 0;
      width: calc(100% - 92px) !important;
    }
.vjs-progress-control .vjs-progress-holder {
    height: 6px;
    }
    .vjs-mouse-display {
    width: 16px;
    height: 16px;
    flex-shrink: 0;
    border-radius: 8px;
    background-color: ${Colors.secondaryRed_300};
    }
    .vjs-slider {
    background-color: ${Colors.greyGrey_200} !important;
    }
    .vjs-play-progress {
      background-color: ${Colors.secondaryRed_300} !important;
    }
    .vjs-play-progress:before {
    font-size: 1.2em;
      color: ${Colors.secondaryRed_300} !important;
    }
    .vjs-load-progress, .vjs-load-progress div {
      background-color: ${Colors.greyGrey_25} !important;
    }

    `->rawCss
}

type videoProps = {
  url: string,
  options: VideoJs.playerOptions,
}

@react.component(: videoProps)
let make = (~url, ~options) => {
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
            " video-js vjs-big-play-centered vjs-fill " ++
            Style.player ++
            " " ++
            Typo.Regular.headline2Force

          videoElement->Element.setClassName(class)

          ref->Element.appendChild(~child=videoElement)
          playerRef.current = Value(videoElement)
          let video = VideoJs.videojs(~id=#Element(videoElement), ~options)
          playerRef.current = Value(video)
          switch options.autoplay {
          | Some(autoplay) => video->VideoJs.autoplay(~autoplay)
          | None => ()
          }
          video->VideoJs.ready(~fn=() => VideoJs.src(video, url), ~sync=true)
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
      className={" video-js vjs-fill " ++ Style.player ++ " " ++ Typo.Regular.headline2Force}
      ref={ReactDOM.Ref.domRef(videoRef)}
    />
  </div>
}
