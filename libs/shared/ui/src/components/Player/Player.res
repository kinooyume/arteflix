open Webapi.Dom
open Emotion

%%raw("import 'video.js/dist/video-js.css'")

module Style = {
  let wrapper =
    ReactDOM.Style.make(~width="100%", ~height="100dvh", ~borderRadius="4px", ())->css

  let player = `
    color: ${Colors.primaryWhite};
    position: relative;

    /* bottom gradient */
    &::after {
      content: "";
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      height: 20%;
      background: linear-gradient(transparent, rgba(0, 0, 0, 0.35));
      pointer-events: none;
      z-index: 1;
      opacity: 1;
      transition: opacity 0.3s;
    }

    /* top gradient */
    &::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 20%;
      background: linear-gradient(rgba(0, 0, 0, 0.35), transparent);
      pointer-events: none;
      z-index: 1;
      opacity: 1;
      transition: opacity 0.3s;
    }

    /* auto-hide controls */
    &.vjs-user-inactive.vjs-playing .vjs-control-bar {
      opacity: 0;
      visibility: visible;
      transition: opacity 0.3s;
    }
    &.vjs-user-inactive.vjs-playing::after,
    &.vjs-user-inactive.vjs-playing::before {
      opacity: 0;
    }
    &.vjs-user-inactive.vjs-playing {
      cursor: none;
    }
    &.vjs-user-active .vjs-control-bar {
      opacity: 1;
      transition: opacity 0.3s;
    }

    /* big play button */
    .vjs-big-play-button {
      display: none !important;
    }

    /* control bar */
    .vjs-control-bar {
      background: transparent !important;
      height: auto !important;
      padding: 0 4% 20px !important;
      z-index: 2;
      display: flex !important;
      align-items: center;
      gap: 8px;
      flex-wrap: wrap;
    }

    /* buttons */
    .vjs-button {
      width: 40px;
      height: 40px;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 0;
    }
    .vjs-button > .vjs-icon-placeholder:before {
      font-size: 1.8em;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    /* push right-side buttons */
    .vjs-volume-panel {
      margin-right: auto !important;
    }
    .vjs-volume-control {
      padding-top: 6px !important;
    }

    /* time display */
    .vjs-time-control {
      position: static !important;
      font-size: 13px;
      font-family: "Netflix Sans", Helvetica, Arial, sans-serif;
      line-height: 40px;
      padding: 0 4px;
      min-width: auto;
    }

    /* progress bar */
    .vjs-progress-control {
      position: absolute !important;
      bottom: 100%;
      left: 0;
      right: 0;
      width: 100% !important;
      height: 20px !important;
      display: flex;
      align-items: flex-end;
    }
    .vjs-progress-control .vjs-progress-holder {
      height: 4px;
      margin: 0;
      border-radius: 2px;
      transition: height 0.1s;
      flex: 1;
    }
    .vjs-progress-control:hover .vjs-progress-holder {
      height: 6px;
    }

    /* track colors */
    .vjs-slider {
      background-color: rgba(255, 255, 255, 0.2) !important;
    }
    .vjs-play-progress {
      background-color: ${Colors.secondaryRed_300} !important;
    }
    .vjs-load-progress,
    .vjs-load-progress div {
      background-color: rgba(255, 255, 255, 0.4) !important;
    }

    /* playhead dot */
    .vjs-play-progress:before {
      font-size: 0;
      content: "" !important;
      display: block;
      width: 12px;
      height: 12px;
      border-radius: 50%;
      background-color: ${Colors.secondaryRed_300};
      position: absolute;
      right: -6px;
      top: 50%;
      transform: translateY(-50%) scale(0);
      transition: transform 0.1s;
    }
    .vjs-progress-control:hover .vjs-play-progress:before {
      transform: translateY(-50%) scale(1);
    }

    /* hide mouse-display tooltip circle */
    .vjs-mouse-display {
      width: 0 !important;
      height: 0 !important;
      background: transparent !important;
    }
    .vjs-mouse-display .vjs-time-tooltip {
      font-size: 12px;
      padding: 4px 8px;
    }

    /* menus */
    .vjs-menu {
      width: 256px !important;
      border: none !important;
      bottom: -12px;
      left: -180px;
      border-radius: 4px;
    }
    .vjs-menu .vjs-menu-content {
      background-color: ${Colors.greyGrey_750} !important;
      justify-content: flex-start !important;
      font-family: "Netflix Sans", Helvetica, Arial, sans-serif !important;
    }
    .vjs-menu .vjs-menu-content .vjs-menu-item {
      display: flex !important;
      padding: 15px 20px !important;
      gap: 10px !important;
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
    .vjs-menu li {
      justify-content: flex-start !important;
    }
    .vjs-menu .vjs-menu-content .vjs-menu-item span {
      text-align: left !important;
      color: ${Colors.greyGrey_100} !important;
      font-family: "Netflix Sans", Helvetica, Arial, sans-serif !important;
      font-size: 14px !important;
      font-style: normal !important;
      font-weight: 400 !important;
      line-height: 16px !important;
    }

    /* mobile */
    ${Responsive.mobileDown} {
      .vjs-menu {
        left: auto;
        right: 0;
        width: min(256px, 90vw) !important;
      }
      .vjs-button {
        padding: 0;
        width: 36px;
        height: 36px;
      }
      .vjs-control-bar {
        padding: 0 3% 12px !important;
        gap: 4px;
      }
      .vjs-progress-control:hover .vjs-progress-holder {
        height: 4px;
      }
      .vjs-progress-control:hover .vjs-play-progress:before {
        transform: translateY(-50%) scale(0);
      }
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
