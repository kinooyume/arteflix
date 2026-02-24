open Webapi.Dom

module Css = {
  @get external style: Dom.element => Dom.cssStyleDeclaration = "style"
  @set external setCssText: (Dom.cssStyleDeclaration, string) => unit = "cssText"
  @set external setOpacity: (Dom.cssStyleDeclaration, string) => unit = "opacity"
  @set external setCursor: (Dom.cssStyleDeclaration, string) => unit = "cursor"
}

module KeyboardEvent = {
  type t
  type target
  @get external key: t => string = "key"
  @get external altKey: t => bool = "altKey"
  @get external ctrlKey: t => bool = "ctrlKey"
  @get external metaKey: t => bool = "metaKey"
  @get external target: t => target = "target"
  @get external tagName: target => string = "tagName"
  @send external preventDefault: t => unit = "preventDefault"
}

@val @scope("document")
external addKeydownListener: (@as("keydown") _, KeyboardEvent.t => unit) => unit = "addEventListener"
@val @scope("document")
external removeKeydownListener: (@as("keydown") _, KeyboardEvent.t => unit) => unit =
  "removeEventListener"

@send external remove: Dom.element => unit = "remove"

let setInactivityTimeout: (VideoJs.t, int) => unit = %raw(`
  function(p, t) { p.options_.inactivityTimeout = t }
`)

let setup = (player, ~title=?) => {
  setInactivityTimeout(player, 3000)

  let playerEl = player->VideoJs.el

  let shared = "position:absolute;left:0;right:0;pointer-events:none;transition:opacity .3s;z-index:1;"

  let topGradient = document->Document.createElement("div")
  topGradient->Css.style->Css.setCssText(
    shared ++ "top:0;height:120px;background:linear-gradient(to bottom,rgba(0,0,0,.7),transparent);",
  )

  let bottomGradient = document->Document.createElement("div")
  bottomGradient->Css.style->Css.setCssText(
    shared ++
    "bottom:0;height:160px;background:linear-gradient(to top,rgba(0,0,0,.7),transparent);",
  )

  playerEl->Element.appendChild(~child=topGradient)
  playerEl->Element.appendChild(~child=bottomGradient)

  switch player->VideoJs.getChild("bigPlayButton") {
  | Some(btn) => btn->VideoJs.hideComponent
  | None => ()
  }

  let setGradientOpacity = value => {
    topGradient->Css.style->Css.setOpacity(value)
    bottomGradient->Css.style->Css.setOpacity(value)
  }

  let onUserActive = () => {
    setGradientOpacity("1")
    playerEl->Css.style->Css.setCursor("")
  }

  let onUserInactive = () =>
    if !VideoJs.paused(player) {
      setGradientOpacity("0")
      playerEl->Css.style->Css.setCursor("none")
    }

  let onKeyDown = e => {
    let tag = e->KeyboardEvent.target->KeyboardEvent.tagName
    if tag === "INPUT" || tag === "TEXTAREA" || tag === "SELECT" {
      ()
    } else if e->KeyboardEvent.altKey || e->KeyboardEvent.ctrlKey || e->KeyboardEvent.metaKey {
      ()
    } else {
      switch e->KeyboardEvent.key {
      | " " | "k" =>
        e->KeyboardEvent.preventDefault
        if VideoJs.paused(player) {
          player->VideoJs.play
        } else {
          player->VideoJs.pause
        }
      | "m" => player->VideoJs.setMuted(!VideoJs.muted(player))
      | "f" =>
        if VideoJs.isFullscreen(player) {
          player->VideoJs.exitFullscreen
        } else {
          player->VideoJs.requestFullscreen
        }
      | "ArrowLeft" =>
        e->KeyboardEvent.preventDefault
        player->VideoJs.setCurrentTime(Math.max(0.0, VideoJs.currentTime(player) -. 10.0))
      | "ArrowRight" =>
        e->KeyboardEvent.preventDefault
        player->VideoJs.setCurrentTime(
          Math.min(VideoJs.duration(player), VideoJs.currentTime(player) +. 10.0),
        )
      | "ArrowUp" =>
        e->KeyboardEvent.preventDefault
        player->VideoJs.setVolume(Math.min(1.0, VideoJs.volume(player) +. 0.1))
      | "ArrowDown" =>
        e->KeyboardEvent.preventDefault
        player->VideoJs.setVolume(Math.max(0.0, VideoJs.volume(player) -. 0.1))
      | _ => ()
      }
    }
  }

  player->VideoJs.on(~event="useractive", ~fn=onUserActive)
  player->VideoJs.on(~event="userinactive", ~fn=onUserInactive)
  addKeydownListener(onKeyDown)

  switch title {
  | Some(t) =>
    switch playerEl->VideoJs.querySelector(".vjs-control-bar") {
    | Some(controlBar) => {
        let titleEl = document->Document.createElement("div")
        titleEl->Element.setTextContent(t)
        titleEl->Css.style->Css.setCssText(
          "position:absolute;left:50%;top:50%;transform:translate(-50%,-50%);pointer-events:none;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;max-width:50%;font-family:Netflix Sans,Tahoma,Verdana,sans-serif;font-size:14px;font-weight:600;color:#fff;",
        )
        controlBar->Element.appendChild(~child=titleEl)
      }
    | None => ()
    }
  | None => ()
  }

  player->VideoJs.on(
    ~event="dispose",
    ~fn=() => {
      removeKeydownListener(onKeyDown)
      topGradient->remove
      bottomGradient->remove
      playerEl->Css.style->Css.setCursor("")
    },
  )
}
