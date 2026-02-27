module Document = Webapi.Dom.Document
module Element = Webapi.Dom.Element

module ClassList = {
  type t
  @get external get: Dom.element => t = "classList"
  @send external add: (t, string) => unit = "add"
  @send external remove: (t, string) => unit = "remove"
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

type episode = {title: string, subtitle: option<string>, href: string, selected: bool, programId: string}
type episodeGroup = {season: string, episodes: array<episode>}

let setOnEpisodeSelect: (VideoJs.t, episode => unit) => unit = %raw(`
  function(player, callback) { player.__onEpisodeSelect = callback }
`)

let updateEpisodeMenu: (VideoJs.t, array<episodeGroup>) => unit = %raw(`
  function(player, groups) {
    var videojs = require('video.js').default;
    var MenuButton = videojs.getComponent('MenuButton');
    var MenuItem = videojs.getComponent('MenuItem');
    var Component = videojs.getComponent('Component');

    function buildItems(pl, gs) {
      var items = [];
      gs.forEach(function(group) {
        if (gs.length > 1) {
          var header = new Component(pl);
          header.addClass('vjs-season-header');
          header.el().textContent = group.season;
          items.push(header);
        }
        group.episodes.forEach(function(ep) {
          var label = ep.title;
          if (ep.subtitle) label = ep.subtitle + ' \u2014 ' + ep.title;
          var item = new MenuItem(pl, { label: label });
          if (ep.selected) item.addClass('vjs-selected');
          item.addClass('vjs-episode-item');
          item.handleClick = function() {
            if (pl.__onEpisodeSelect) {
              pl.__onEpisodeSelect(ep);
            } else {
              window.location.href = ep.href;
            }
          };
          items.push(item);
        });
      });
      return items;
    }

    var controlBar = player.getChild('controlBar');
    if (!controlBar) return;

    var btn = controlBar.getChild('EpisodeMenuButton');
    if (btn) {
      btn._groups = groups;
      btn.update();
    } else {
      class EpisodeMenuButton extends MenuButton {
        constructor(pl, options) {
          super(pl, options);
          this._groups = groups;
          this.controlText('Episodes');
          this.addClass('vjs-episodes-button');
        }
        createItems() {
          return buildItems(this.player(), this._groups || []);
        }
      }
      videojs.registerComponent('EpisodeMenuButton', EpisodeMenuButton);
      controlBar.addChild('EpisodeMenuButton', {}, controlBar.children().length - 1);
    }
  }
`)

@set external setInnerHTML: (Dom.element, string) => unit = "innerHTML"

let updateTitle = (player, ~title, ~subtitle=?) => {
  let playerEl = player->VideoJs.el
  switch playerEl->VideoJs.querySelector(".vjs-netflix-title") {
  | Some(el) =>
    let html = switch subtitle {
    | Some(sub) =>
      `<span style="font-weight:400;color:rgba(255,255,255,.5);font-size:13px">${title}</span>` ++
      `<span style="margin-left:8px;font-weight:700;color:#fff;font-size:15px">${sub}</span>`
    | None => title
    }
    el->setInnerHTML(html)
  | None => ()
  }
}

let hiddenClass = "netflix-controls-hidden"

let makeKeyHandler = (player: VideoJs.t) => (e: KeyboardEvent.t) => {
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

let setup = (player, ~title=?) => {
  setInactivityTimeout(player, 3000)

  let playerEl = player->VideoJs.el

  let gradientBase = "position:absolute;left:0;right:0;pointer-events:none;z-index:1;"

  let topGradient = Webapi.Dom.document->Document.createElement("div")
  topGradient->Element.setClassName("netflix-gradient")
  topGradient->Element.setAttribute("style",
    gradientBase ++ "top:0;height:120px;background:linear-gradient(to bottom,rgba(0,0,0,.7),transparent);",
  )

  let bottomGradient = Webapi.Dom.document->Document.createElement("div")
  bottomGradient->Element.setClassName("netflix-gradient")
  bottomGradient->Element.setAttribute("style",
    gradientBase ++ "bottom:0;height:160px;background:linear-gradient(to top,rgba(0,0,0,.7),transparent);",
  )

  playerEl->Element.appendChild(~child=topGradient)
  playerEl->Element.appendChild(~child=bottomGradient)

  switch player->VideoJs.getChild("bigPlayButton") {
  | Some(btn) => btn->VideoJs.hideComponent
  | None => ()
  }

  let onUserActive = () => {
    playerEl->ClassList.get->ClassList.remove(hiddenClass)
  }

  let onUserInactive = () =>
    if !VideoJs.paused(player) {
      playerEl->ClassList.get->ClassList.add(hiddenClass)
    }

  player->VideoJs.on(~event="useractive", ~fn=onUserActive)
  player->VideoJs.on(~event="userinactive", ~fn=onUserInactive)

  switch playerEl->VideoJs.querySelector(".vjs-control-bar") {
  | Some(controlBar) => {
      let titleEl = Webapi.Dom.document->Document.createElement("div")
      titleEl->Element.setClassName("vjs-netflix-title")
      titleEl->Element.setAttribute("style",
        "position:absolute;left:50%;top:50%;transform:translate(-50%,-50%);pointer-events:none;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;max-width:50%;font-family:Netflix Sans,Tahoma,Verdana,sans-serif;font-size:14px;font-weight:600;color:#fff;display:flex;align-items:baseline;gap:0;",
      )
      switch title {
      | Some(t) => titleEl->Element.setTextContent(t)
      | None => ()
      }
      controlBar->Element.appendChild(~child=titleEl)
    }
  | None => ()
  }

  let keyHandler = makeKeyHandler(player)
  addKeydownListener(keyHandler)

  player->VideoJs.on(
    ~event="dispose",
    ~fn=() => {
      removeKeydownListener(keyHandler)
      topGradient->remove
      bottomGradient->remove
    },
  )
}
